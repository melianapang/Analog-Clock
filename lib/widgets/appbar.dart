import 'package:analog_clock/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.strTitle,
  }) : super(key: key);

  final String strTitle;
  final size = Size.fromHeight(88.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: size,
      child: AppBar(
        toolbarHeight: 88.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          strTitle,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: baseBlue,
      ),
    );
  }

  @override
  Size get preferredSize => size;
}
