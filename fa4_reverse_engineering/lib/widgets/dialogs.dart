import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/constants/app_sizes.dart';
import 'package:fa4_reverse_engineering/theme/app_theme.dart';

class _DialogButton extends StatelessWidget {
  const _DialogButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: primary,
        backgroundColor: primary.withOpacity(0.12),
        shape: const StadiumBorder(),
      ),
      child: Text(label),
    );
  }
}

AlertDialog _buildDialog(
  BuildContext context, {
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  final textColor = Theme.of(context).colorScheme.onSurface;
  return AlertDialog(
    backgroundColor: dialogColor(context),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kDialogRadius),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    ),
    content: Text(message, style: TextStyle(fontSize: 14, color: textColor)),
    actions: actions,
  );
}

Future<void> showMessageDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => _buildDialog(
      ctx,
      title: title,
      message: message,
      actions: [
        _DialogButton(label: 'OK', onPressed: () => Navigator.of(ctx).pop()),
      ],
    ),
  );
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String cancelLabel = 'Cancel',
  String confirmLabel = 'Yes',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => _buildDialog(
      ctx,
      title: title,
      message: message,
      actions: [
        _DialogButton(
          label: cancelLabel,
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        _DialogButton(
          label: confirmLabel,
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}
