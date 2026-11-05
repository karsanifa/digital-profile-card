import 'package:flutter/material.dart';

class SkillChips extends StatelessWidget {
  const SkillChips({super.key});

  static const _skills = [
    'Flutter', 'Dart', 'Firebase', 'Git', 'REST API', 'Figma', 'SQLite',
  ];

  @override
  Widget build(BuildContext context) {
    // Wrap = Row yang otomatis turun ke baris baru saat ruang habis.
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [for (final skill in _skills) Chip(label: Text(skill))],
    );
  }
}