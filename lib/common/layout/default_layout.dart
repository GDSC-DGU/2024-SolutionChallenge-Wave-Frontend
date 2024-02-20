import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool isSingleChildScrollViewNeeded; // Make it non-optional with a default value
  final bool isNeededCenterAppbar;


  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.isSingleChildScrollViewNeeded = false, // Default to false
    this.isNeededCenterAppbar = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: isSingleChildScrollViewNeeded
          ? SingleChildScrollView(child: child) // Wrap child with SingleChildScrollView if needed
          : child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        title: Align(
          alignment: isNeededCenterAppbar ? Alignment.center : Alignment.centerLeft,
          child: Text(
            title!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }
}
