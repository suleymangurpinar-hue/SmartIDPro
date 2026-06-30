import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/enterprise_workspace_module.dart';

class EnterpriseSidebar extends StatelessWidget {
  const EnterpriseSidebar({
    super.key,
    this.selected = EnterpriseWorkspaceModule.scan,
    this.onSelected,
  });

  final EnterpriseWorkspaceModule selected;
  final ValueChanged<EnterpriseWorkspaceModule>? onSelected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, .04),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, .08)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4A64A), Color(0xFFFFD78A)],
                  ),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.black),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: EnterpriseWorkspaceModule.values
                      .map(
                        (module) => _Item(
                          icon: module.icon,
                          label: module.title,
                          active: selected == module,
                          onTap: () => onSelected?.call(module),
                        ),
                      )
                      .toList(),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF1F2937),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 54,
          height: 54,
          margin: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFD4A64A) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: active ? Colors.black : Colors.white60),
        ),
      ),
    );
  }
}
