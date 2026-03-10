import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty &&
            !label.contains("@") &&
            !label.contains("First") &&
            !label.contains(
              "Last",
            )) // Heuristic for title above field if needed, but design shows placeholder behavior or title above.
          // Based on "Fields: Username / ID ... prefix icon: person", let's assume standard input decoration with label as hint or labelText.
          // Actually design says "Username / ID" as a field label above or inside?
          // "Title: ... Subtitle: ... Fields: Username / ID prefix icon: person" - usually means label above or hint inside.
          // I will put label above for better accessibility and clarity if it's not the hint.
          // Let's assume label is the title above the field.
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 4),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: label.contains("Email")
                  ? "name@example.com"
                  : (label.contains("Username")
                        ? "e.g. j.doe@hospital.com"
                        : label), // Dynamic hint based on label for demo
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppTheme.textSecondary)
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppTheme.primaryBlue,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
