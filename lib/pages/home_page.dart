// Página inicial do app, permite alternar tema, idioma e navegar para cadastro de pessoa ou carro
// Importações necessárias para o funcionamento da página.
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

// Widget HomePage, exibe a tela principal com opções de navegação e alternância de tema/idioma.
class HomePage extends StatelessWidget {
  // Função chamada ao alternar o tema (claro/escuro)
  final VoidCallback onThemeToggle;
  // Função chamada ao alternar o idioma (pt/en)
  final VoidCallback onLanguageToggle;
  // Estado atual do tema
  final ThemeMode themeMode;
  // Idioma atual
  final String language;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.themeMode,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    // Retorna o Scaffold principal da página
    return Scaffold(
      // Barra superior customizada
      appBar: CustomAppBar(
        title: language == 'en' ? 'GENERAL REGISTRATION' : 'CADASTRO GERAL',
        actions: [
          // Botão para alternar idioma
          IconButton(
            icon: const Icon(Icons.language),
            tooltip:
                language == 'en' ? 'Change to Portuguese' : 'Mudar para Inglês',
            onPressed: onLanguageToggle,
          ),
          // Botão para alternar tema
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode),
            tooltip: language == 'en' ? 'Toggle theme' : 'Alternar tema',
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // SingleChildScrollView permite rolar o conteúdo em telas pequenas
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              // Center centraliza o conteúdo verticalmente e horizontalmente
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  alignment: Alignment.center,
                  // Column organiza os widgets verticalmente, centralizando-os
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cabeçalho com ícone e mensagem de boas-vindas
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: Column(
                          children: [
                            Icon(Icons.app_registration,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(height: 18),
                            Text(
                              language == 'en'
                                  ? 'Welcome! Register a person or a car.'
                                  : 'Bem-vindo! Cadastre uma pessoa ou um carro.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.person_add_alt_1),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/pessoa'),
                        label: Text(language == 'en'
                            ? 'Register Person'
                            : 'Cadastro de Pessoa'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.directions_car_filled),
                        onPressed: () => Navigator.pushNamed(context, '/carro'),
                        label: Text(language == 'en'
                            ? 'Register Car'
                            : 'Cadastro de Carro'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
