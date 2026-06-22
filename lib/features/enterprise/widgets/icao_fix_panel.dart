import 'package:flutter/material.dart';

class IcaoFixPanel
    extends StatelessWidget {
  const IcaoFixPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
        16,
      ),
      child: Column(
        children: const [
          _Item(
            "Head Center",
          ),
          _Item(
            "Eye Position",
          ),
          _Item(
            "Top Margin",
          ),
          _Item(
            "Chin Margin",
          ),
          _Item(
            "Background",
          ),
        ],
      ),
    );
  }
}

class _Item
    extends StatelessWidget {
  final String title;

  const _Item(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: const [
          Icon(
            Icons.check_circle,
            color:
                Color(
              0xFF34D399,
            ),
            size: 18,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              '',
            ),
          ),
        ],
      ),
    );
  }
}