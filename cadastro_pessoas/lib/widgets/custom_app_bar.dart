// AppBar customizado para uso em toda a aplicação, permite personalizar título, ações e centralização.
import 'package:flutter/material.dart';

// Widget CustomAppBar, implementa PreferredSizeWidget para uso como AppBar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  // Construtor recebe título, lista de ações e se o título será centralizado.
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    // Retorna um AppBar estilizado conforme o tema da aplicação.
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: centerTitle,
      actions: actions,
      elevation: 2,
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
    );
  }

  // Define o tamanho preferido do AppBar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}