import 'dart:ui';
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, .04),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, .08),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),

                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6FAAFF), Color(0xFF4F8CFF)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x554F8CFF),
                        blurRadius: 30,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: Column(
                    children: const [
                      _MenuIcon(Icons.grid_view_rounded, true),
                      _MenuIcon(Icons.image_outlined),
                      _MenuIcon(Icons.auto_fix_high_outlined),
                      _MenuIcon(Icons.crop_outlined),
                      _MenuIcon(Icons.psychology_alt_outlined),
                      _MenuIcon(Icons.verified_user_outlined),
                      _MenuIcon(Icons.print_outlined),
                      _MenuIcon(Icons.folder_outlined),
                      _MenuIcon(Icons.history_outlined),
                    ],
                  ),
                ),

                Container(
                  width: 52,
                  height: 52,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF202634),
                    border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, .08),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white70,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  final IconData icon;
  final bool active;

  const _MenuIcon(this.icon, [this.active = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: active ? const Color(0xFF4F8CFF) : Colors.transparent,
        border: Border.all(
          color: active
              ? Colors.transparent
              : const Color.fromRGBO(255, 255, 255, .06),
        ),
        boxShadow: active
            ? const [
                BoxShadow(
                  color: Color(0x444F8CFF),
                  blurRadius: 22,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        size: 22,
        color: active ? Colors.white : Colors.white60,
      ),
    );
  }
}
