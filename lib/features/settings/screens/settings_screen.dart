import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_settings.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        final settings = provider.settings;

        return Row(
          children: [
            Expanded(
              flex: 5,
              child: _SettingsPanel(
                title: 'WORKFLOW',
                children: [
                  _SwitchTile(
                    label: 'Auto background',
                    value: settings.autoBackground,
                    onChanged: (value) => _save(
                      context,
                      settings.copyWith(autoBackground: value),
                    ),
                  ),
                  _SwitchTile(
                    label: 'Auto retouch',
                    value: settings.autoRetouch,
                    onChanged: (value) =>
                        _save(context, settings.copyWith(autoRetouch: value)),
                  ),
                  _SwitchTile(
                    label: 'Auto clothing',
                    value: settings.autoClothing,
                    onChanged: (value) =>
                        _save(context, settings.copyWith(autoClothing: value)),
                  ),
                  _SwitchTile(
                    label: 'Archive customers',
                    value: settings.archiveCustomers,
                    onChanged: (value) => _save(
                      context,
                      settings.copyWith(archiveCustomers: value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              flex: 5,
              child: _SettingsPanel(
                title: 'DEFAULTS',
                children: [
                  _OptionRow(
                    label: 'Country',
                    value: settings.defaultCountryCode,
                    options: const [
                      'TR',
                      'US',
                      'DE',
                      'FR',
                      'GB',
                      'CA',
                      'JP',
                      'AE',
                    ],
                    onChanged: (value) => _save(
                      context,
                      settings.copyWith(defaultCountryCode: value),
                    ),
                  ),
                  _OptionRow(
                    label: 'Document',
                    value: settings.defaultDocumentType,
                    options: const [
                      'Biometric Passport',
                      'Visa / Passport',
                      'Schengen Visa',
                      'Passport',
                      'Visa',
                    ],
                    onChanged: (value) => _save(
                      context,
                      settings.copyWith(defaultDocumentType: value),
                    ),
                  ),
                  _OptionRow(
                    label: 'DPI',
                    value: settings.defaultDpi.toString(),
                    options: const ['300', '400', '600'],
                    onChanged: (value) => _save(
                      context,
                      settings.copyWith(defaultDpi: int.tryParse(value) ?? 300),
                    ),
                  ),
                  _InfoRow(
                    label: 'Export folder',
                    value: settings.exportFolder,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _save(BuildContext context, AppSettings settings) {
    context.read<SettingsProvider>().update(settings);
  }
}

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: _rowDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFD4A64A),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: _rowDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: const Color(0xFF111827),
              items: options
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
              onChanged: (next) {
                if (next == null) {
                  return;
                }

                onChanged(next);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: _rowDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _rowDecoration() {
  return BoxDecoration(
    color: const Color(0xFF182232),
    borderRadius: BorderRadius.circular(16),
  );
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111827),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
  );
}
