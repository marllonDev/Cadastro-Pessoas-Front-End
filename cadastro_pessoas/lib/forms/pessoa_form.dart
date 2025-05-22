// Formulário para cadastro de pessoas. Permite inserir nome, ano e email.
import 'package:flutter/material.dart';

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
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Libera os controladores ao destruir o widget.
    _nomeController.dispose();
    _anoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Labels dinâmicos conforme o idioma selecionado.
  String get _nomeLabel => widget.language == 'en' ? 'Name' : 'Nome';
  String get _anoLabel => widget.language == 'en' ? 'Year' : 'Ano';
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
                        // Campo para ano de nascimento
                        TextFormField(
                          controller: _anoController,
                          decoration: InputDecoration(
                              labelText: _anoLabel,
                              border: const OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return widget.language == 'en'
                                  ? 'Required'
                                  : 'Obrigatório';
                            }
                            final year = int.tryParse(value);
                            if (year == null ||
                                year < 1900 ||
                                year > DateTime.now().year) {
                              return widget.language == 'en'
                                  ? 'Enter a valid year'
                                  : 'Informe um ano válido';
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.onSave({
                                  'nome': _nomeController.text.trim(),
                                  'ano': int.parse(_anoController.text.trim()),
                                  'email': _emailController.text.trim(),
                                });
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
