import 'package:flutter/material.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.actions,
    this.showBack = true,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showBack;

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 56 : 72);

  @override
  Widget build(BuildContext context) {
    final b = context.brand;
    return Container(
      decoration: BoxDecoration(
        color: b.card,
        border: Border(
          bottom: BorderSide(color: b.line, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              if (showBack)
                IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: Icon(Icons.arrow_back, color: b.ink, size: 20),
                  splashRadius: 20,
                ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: b.ink,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: b.ink3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}
