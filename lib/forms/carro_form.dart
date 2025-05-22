// Formulário para cadastro de carros. Permite inserir nome, ano, marca e preço do carro.
// Importações necessárias para o funcionamento do formulário.
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Widget de formulário de carro, recebe função de salvamento e idioma.
class CarroForm extends StatefulWidget {
  // Função callback chamada ao salvar o formulário
  final Function(Map<String, dynamic>) onSave;
  // Idioma selecionado (pt ou en)
  final String language;
  const CarroForm({super.key, required this.onSave, required this.language});

  @override
  State<CarroForm> createState() => _CarroFormState();
}

// Estado do formulário de carro, gerencia os controladores e validação.
class _CarroFormState extends State<CarroForm> {
  // Chave global para identificar o formulário e validar
  final _formKey = GlobalKey<FormState>();
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  @override
  void dispose() {
    // Libera os controladores ao destruir o widget.
    _nomeController.dispose();
    _anoController.dispose();
    _marcaController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  // Labels dinâmicos conforme o idioma selecionado.
  String get _nomeLabel => widget.language == 'en' ? 'Name' : 'Nome';
  String get _anoLabel => widget.language == 'en' ? 'Year' : 'Ano';
  String get _marcaLabel => widget.language == 'en' ? 'Brand' : 'Marca';
  String get _precoLabel => widget.language == 'en' ? 'Price' : 'Preço';
  String get _saveLabel => widget.language == 'en' ? 'Save' : 'Salvar';

  @override
  Widget build(BuildContext context) {
    // Usa layout responsivo para centralizar o formulário.
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título do formulário
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  widget.language == 'en'
                      ? 'Car Registration'
                      : 'Cadastro de Carro',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              // Card para destacar o formulário
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Campo para nome do carro
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                              labelText: _nomeLabel,
                              border: const OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? (widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório')
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Campo para ano do carro
                        TextFormField(
                          controller: _anoController,
                          decoration: InputDecoration(
                              labelText: _anoLabel,
                              border: const OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? (widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório')
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Campo para marca do carro
                        TextFormField(
                          controller: _marcaController,
                          decoration: InputDecoration(
                              labelText: _marcaLabel,
                              border: const OutlineInputBorder()),
                          validator: (value) => value == null || value.isEmpty
                              ? (widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório')
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Campo para preço do carro
                        TextFormField(
                          controller: _precoController,
                          decoration: InputDecoration(
                              labelText: _precoLabel,
                              border: const OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? (widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório')
                              : null,
                        ),
                        const SizedBox(height: 24),
                        // Botão de salvar, chama onSave se o formulário for válido
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final data = {
                                    'nome': _nomeController.text.trim(),
                                    'ano': int.tryParse(
                                            _anoController.text.trim()) ??
                                        0,
                                    'marca': _marcaController.text.trim(),
                                    'preco': double.tryParse(
                                            _precoController.text.trim()) ??
                                        0.0,
                                  };
                                  final baseUrl = getBackendBaseUrl();
                                  final url = Uri.parse(
                                      '${getBackendBaseUrl()}/carros');
                                  final response = await http
                                      .post(
                                        url,
                                        headers: {
                                          'Content-Type': 'application/json'
                                        },
                                        body: jsonEncode(data),
                                      )
                                      .timeout(const Duration(seconds: 10));

                                  if (response.statusCode == 201) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(widget.language == 'en'
                                            ? 'Car saved successfully!'
                                            : 'Carro salvo com sucesso!'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    final errorMessage = response.statusCode ==
                                            400
                                        ? jsonDecode(response.body)['error']
                                        : widget.language == 'en'
                                            ? 'Error saving car (Code \${response.statusCode})'
                                            : 'Erro ao salvar carro (Código \${response.statusCode})';
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(errorMessage)),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(widget.language == 'en'
                                          ? 'Network error: ${e.toString()}'
                                          : 'Erro de rede: ${e.toString()}'),
                                    ),
                                  );
                                }
                              }
                            },
                            label: Text(_saveLabel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Função utilitária para obter a base da URL do backend
String getBackendBaseUrl() {
  if (kIsWeb) {
    return 'http://localhost:8000';
  } else {
    return 'http://10.0.2.2:8000';
  }
}
