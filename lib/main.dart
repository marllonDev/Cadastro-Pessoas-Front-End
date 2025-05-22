// Ponto de entrada da aplicação Flutter para cadastro de pessoas e carros.
// Importações necessárias para o funcionamento do app.
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'forms/carro_form.dart';
import 'forms/pessoa_form.dart';
import 'pages/home_page.dart';

// Função principal do aplicativo, ponto de entrada.
void main() {
  runApp(const MyApp());
}

// Widget principal do app, gerencia tema e idioma.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// Estado do MyApp, controla tema, idioma e rotas.
class _MyAppState extends State<MyApp> {
  // Estado do tema (claro ou escuro)
  ThemeMode _themeMode = ThemeMode.light;
  // Estado do idioma (pt ou en)
  String _language = 'pt';

  // Retorna a URL base do backend conforme ambiente (web ou emulador).
  String get backendBaseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  // Alterna entre tema claro e escuro.
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Alterna entre português e inglês.
  void _toggleLanguage() {
    setState(() {
      _language = _language == 'pt' ? 'en' : 'pt';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Configuração do MaterialApp, temas, rotas e tela inicial.
    return MaterialApp(
      title: 'Cadastro Geral',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: HomePage(
        onThemeToggle: _toggleTheme,
        onLanguageToggle: _toggleLanguage,
        themeMode: _themeMode,
        language: _language,
      ),
      routes: {
        // Rota para cadastro de pessoa
        '/pessoa': (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                  _language == 'en'
                      ? 'Person Registration'
                      : 'Cadastro de Pessoa',
                ),
              ),
              body: PessoaForm(
                language: _language,
                onSave: (data) async {
                  // Envia os dados para o backend ao salvar pessoa
                  final url = Uri.parse('$backendBaseUrl/pessoas');
                  final response = await http.post(
                    url,
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(data),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
        // Rota para cadastro de carro
        '/carro': (context) => Scaffold(
              appBar: AppBar(
                title: Text(
                  _language == 'en' ? 'Car Registration' : 'Cadastro de Carro',
                ),
              ),
              body: CarroForm(
                language: _language,
                onSave: (data) async {
                  // Envia os dados para o backend ao salvar carro
                  final url = Uri.parse('$backendBaseUrl/carros');
                  final response = await http.post(
                    url,
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(data),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
      },
    );
  }
}

// Função auxiliar para simular salvamento de dados (não utilizada diretamente no fluxo principal).
Future<void> _saveData(Map<String, dynamic> data, String backendBaseUrl) async {
  await Future.delayed(const Duration(milliseconds: 500)); // Simula um delay
  final url = Uri.parse('$backendBaseUrl/pessoas');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to save data');
  }
}
