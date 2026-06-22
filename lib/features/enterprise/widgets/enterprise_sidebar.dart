import 'dart:ui';

import 'package:flutter/material.dart';

class EnterpriseSidebar extends StatelessWidget {
  const EnterpriseSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 40,
          sigmaY: 40,
        ),
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
              255,
              255,
              255,
              .04,
            ),
            borderRadius:
                BorderRadius.circular(
              32,
            ),
            border: Border.all(
              color:
                  const Color.fromRGBO(
                255,
                255,
                255,
                .08,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFFD4A64A),
                      Color(0xFFFFD78A),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              const _Item(
                Icons.dashboard_outlined,
                true,
              ),
              const _Item(
                Icons.face_outlined,
              ),
              const _Item(
                Icons.auto_fix_high,
              ),
              const _Item(
                Icons.check_circle_outline,
              ),
              const _Item(
                Icons.print_outlined,
              ),
              const _Item(
                Icons.folder_outlined,
              ),

              const Spacer(),

              const Padding(
                padding: EdgeInsets.only(
                  bottom: 18,
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Color(0xFF1F2937),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
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

class _Item extends StatelessWidget {
  final IconData icon;
  final bool active;

  const _Item(
    this.icon, [
    this.active = false,
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFD4A64A)
            : Colors.transparent,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Icon(
        icon,
        color: active
            ? Colors.black
            : Colors.white60,
      ),
    );
  }
}