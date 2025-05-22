// Formulário para cadastro de pessoas. Permite inserir nome, idade e email.
// Importações necessárias para o funcionamento do formulário.
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Widget de formulário de pessoa, recebe função de salvamento e idioma.
class PessoaForm extends StatefulWidget {
  // Função callback chamada ao salvar o formulário
  final Function(Map<String, dynamic>) onSave;
  // Idioma selecionado (pt ou en)
  final String language;
  const PessoaForm({super.key, required this.onSave, required this.language});

  @override
  State<PessoaForm> createState() => _PessoaFormState();
}

// Estado do formulário de pessoa, gerencia os controladores e validação.
class _PessoaFormState extends State<PessoaForm> {
  // Chave global para identificar o formulário e validar
  final _formKey = GlobalKey<FormState>();
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Libera os controladores ao destruir o widget.
    _nomeController.dispose();
    _idadeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Labels dinâmicos conforme o idioma selecionado.
  String get _nomeLabel => widget.language == 'en' ? 'Name' : 'Nome';
  String get _idadeLabel => widget.language == 'en' ? 'Age' : 'Idade';
  String get _emailLabel => widget.language == 'en' ? 'Email' : 'E-mail';
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
                      ? 'Person Registration'
                      : 'Cadastro de Pessoa',
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
                        // Campo para nome da pessoa
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                              labelText: _nomeLabel,
                              border: const OutlineInputBorder()),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? (widget.language == 'en'
                                      ? 'Required'
                                      : 'Obrigatório')
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        // Campo para idade
                        TextFormField(
                          controller: _idadeController,
                          decoration: InputDecoration(
                              labelText: _idadeLabel,
                              border: const OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório';
                            }
                            final idade = int.tryParse(value);
                            if (idade == null || idade < 0 || idade > 120) {
                              return widget.language == 'en'
                                  ? 'Enter a valid age'
                                  : 'Informe uma idade válida';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Campo para e-mail
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: _emailLabel,
                              border: const OutlineInputBorder()),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório';
                            }
                            final emailRegex =
                                RegExp(r"^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}");
                            if (!emailRegex.hasMatch(value.trim())) {
                              return widget.language == 'en'
                                  ? 'Enter a valid email'
                                  : 'Informe um e-mail válido';
                            }
                            return null;
                          },
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
                                final data = {
                                  'nome': _nomeController.text.trim(),
                                  'idade':
                                      int.parse(_idadeController.text.trim()),
                                  'email': _emailController.text.trim(),
                                };
                                try {
                                  final url = Uri.parse(
                                      '${getBackendBaseUrl()}/pessoas');
                                  final response = await http.post(
                                    url,
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: jsonEncode(data),
                                  );

                                  if (response.statusCode == 201) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(widget.language == 'en'
                                              ? 'Person saved successfully!'
                                              : 'Pessoa salva com sucesso!')),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    final errorMessage = response.statusCode ==
                                            400
                                        ? jsonDecode(response.body)['error']
                                        : widget.language == 'en'
                                            ? 'Error saving person (Code ${response.statusCode})'
                                            : 'Erro ao salvar pessoa (Código ${response.statusCode})';

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
