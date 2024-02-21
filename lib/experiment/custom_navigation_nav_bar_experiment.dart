// // import 'dart:math';
// //
// // import 'package:flutter/material.dart';
// // import 'package:meta/meta.dart';
// // import 'package:wave/country/component/nav_button.dart';
// // import 'package:wave/country/component/nav_custom_painter.dart';
// //
// //
// // typedef _LetIndexPage = bool Function(int value);
// //
// // class CustomAnimationNavBar extends StatefulWidget {
// //   final List<Widget> items;
// //   final int index;
// //   final Color color;
// //   final Color? buttonBackgroundColor;
// //   final Color backgroundColor;
// //   final ValueChanged<int>? onTap;
// //   final _LetIndexPage letIndexChange;
// //   final Curve animationCurve;
// //   final Duration animationDuration;
// //   final double height;
// //
// //   CustomAnimationNavBar({
// //     Key? key,
// //     required this.items,
// //     this.index = 0,
// //     this.color = Colors.white,
// //     this.buttonBackgroundColor,
// //     this.backgroundColor = Colors.blueAccent,
// //     this.onTap,
// //     _LetIndexPage? letIndexChange,
// //     this.animationCurve = Curves.easeOut,
// //     this.animationDuration = const Duration(milliseconds: 600),
// //     this.height = 80.0,
// //   })  : letIndexChange = letIndexChange ?? ((_) => true),
// //         assert(items != null),
// //         assert(items.length >= 1),
// //         assert(0 <= index && index < items.length),
// //         assert(0 <= height && height <= 80.0),
// //         super(key: key);
// //
// //   @override
// //   CustomAnimationNavBarState createState() => CustomAnimationNavBarState();
// // }
// //
// // class CustomAnimationNavBarState extends State<CustomAnimationNavBar>
// //     with SingleTickerProviderStateMixin {
// //   late double _startingPos;
// //   int _endingIndex = 0;
// //   late double _pos;
// //   double _buttonHide = 0;
// //   late Widget _icon;
// //   late AnimationController _animationController;
// //   late int _length;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _icon = widget.items[widget.index];
// //     _length = widget.items.length;
// //     _pos = widget.index / _length;
// //     _startingPos = widget.index / _length;
// //     _animationController = AnimationController(vsync: this, value: _pos);
// //     _animationController.addListener(() {
// //       setState(() {
// //         _pos = _animationController.value;
// //         final endingPos = _endingIndex / widget.items.length;
// //         final middle = (endingPos + _startingPos) / 2;
// //         if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
// //           _icon = widget.items[_endingIndex];
// //         }
// //         // _buttonHide 계산
// //         double calculatedButtonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
// //         _buttonHide = min(calculatedButtonHide, 0.52); /// ⭐️ 탭 이동시 얼마까지 내려갈 것인가?
// //         // _buttonHide =
// //         //     (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
// //       });
// //     });
// //   }
// //
// //   @override
// //   void didUpdateWidget(CustomAnimationNavBar oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     if (oldWidget.index != widget.index) {
// //       final newPosition = widget.index / _length;
// //       _startingPos = _pos;
// //       _endingIndex = widget.index;
// //       _animationController.animateTo(newPosition,
// //           duration: widget.animationDuration, curve: widget.animationCurve);
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     print('startingPos: $_buttonHide');
// //     print(_buttonHide);
// //     Size size = MediaQuery.of(context).size * 1;
// //     return Container(
// //       color: widget.backgroundColor,
// //       height: widget.height,
// //       child: Stack(
// //         clipBehavior: Clip.none,
// //         alignment: Alignment.bottomCenter,
// //         children: <Widget>[
// //           Positioned(
// //             bottom: -40 - (80.0 - widget.height),
// //             left: Directionality.of(context) == TextDirection.rtl
// //                 ? null
// //                 : _pos * size.width,
// //             right: Directionality.of(context) == TextDirection.rtl
// //                 ? _pos * size.width
// //                 : null,
// //             width: size.width / _length,
// //             child: Center(
// //               child: Transform.translate(
// //                 offset: Offset(
// //                   0,
// //                   -(1 - _buttonHide) * 80,
// //                 ),
// //                 child: Material(
// //                   color: widget.buttonBackgroundColor ?? widget.color,
// //                   type: MaterialType.circle,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: _icon,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             left: 0,
// //             right: 0,
// //             bottom: 0 - (80.0 - widget.height),
// //             child: CustomPaint(
// //               painter: NavCustomPainter(
// //                   _pos, _length, widget.color, Directionality.of(context)),
// //               child: Container(
// //                 height: 80.0,
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             left: 0,
// //             right: 0,
// //             bottom: 0 - (80.0 - widget.height),
// //             child: SizedBox(
// //                 height: 80.0,
// //                 child: Row(
// //                     children: widget.items.map((item) {
// //                       return NavButton(
// //                         onTap: _buttonTap,
// //                         position: _pos,
// //                         length: _length,
// //                         index: widget.items.indexOf(item),
// //                         child: Center(child: item),
// //                       );
// //                     }).toList())),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   void setPage(int index) {
// //     _buttonTap(index);
// //   }
// //
// //   void _buttonTap(int index) {
// //     print('you here@@@@ $index');
// //     if (!widget.letIndexChange(index)) {
// //       return;
// //     }
// //     if (widget.onTap != null) {
// //       widget.onTap!(index);
// //     }
// //     final newPosition = index / _length;
// //     setState(() {
// //       _startingPos = _pos;
// //       _endingIndex = index;
// //       _animationController.animateTo(newPosition,
// //           duration: widget.animationDuration, curve: widget.animationCurve);
// //     });
// //   }
// // }
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:wave/country/component/nav_button.dart';
// import 'package:wave/country/component/nav_custom_painter.dart';
//
//
// typedef _LetIndexPage = bool Function(int value);
//
// class CustomAnimationNavBar extends StatefulWidget {
//   final List<Widget> items;
//   final int index;
//   final Color color;
//   final Color? buttonBackgroundColor;
//   final Color backgroundColor;
//   final ValueChanged<int>? onTap;
//   final _LetIndexPage letIndexChange;
//   final Curve animationCurve;
//   final Duration animationDuration;
//   final double height;
//
//   CustomAnimationNavBar({
//     Key? key,
//     required this.items,
//     this.index = 0,
//     this.color = Colors.white,
//     this.buttonBackgroundColor,
//     this.backgroundColor = Colors.blueAccent,
//     this.onTap,
//     _LetIndexPage? letIndexChange,
//     this.animationCurve = Curves.easeOut,
//     this.animationDuration = const Duration(milliseconds: 600),
//     this.height = 80.0,
//   })  : letIndexChange = letIndexChange ?? ((_) => true),
//         assert(items != null),
//         assert(items.length >= 1),
//         assert(0 <= index && index < items.length),
//         assert(0 <= height && height <= 80.0),
//         super(key: key);
//
//   @override
//   CustomAnimationNavBarState createState() => CustomAnimationNavBarState();
// }
//
// class CustomAnimationNavBarState extends State<CustomAnimationNavBar>
//     with SingleTickerProviderStateMixin {
//   late double _startingPos;
//   int _endingIndex = 0;
//   late double _pos;
//   double _buttonHide = 0;
//   late Widget _icon;
//   late AnimationController _animationController;
//   late int _length;
//
//   @override
//   void initState() {
//     super.initState();
//     _icon = widget.items[widget.index];
//     _length = widget.items.length;
//     _pos = widget.index / _length;
//     _startingPos = widget.index / _length;
//     _animationController = AnimationController(vsync: this, value: _pos);
//     _animationController.addListener(() {
//       setState(() {
//         _pos = _animationController.value;
//         final endingPos = _endingIndex / widget.items.length;
//         final middle = (endingPos + _startingPos) / 2;
//         if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
//           _icon = widget.items[_endingIndex];
//         }
//         // _buttonHide 계산
//         double calculatedButtonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
//         _buttonHide = min(calculatedButtonHide, 0.52); /// ⭐️ 탭 이동시 얼마까지 내려갈 것인가?
//         // _buttonHide =
//         //     (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
//       });
//     });
//   }
//
//   @override
//   void didUpdateWidget(CustomAnimationNavBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.index != widget.index) {
//       final newPosition = widget.index / _length;
//       _startingPos = _pos;
//       _endingIndex = widget.index;
//       _animationController.animateTo(newPosition,
//           duration: widget.animationDuration, curve: widget.animationCurve);
//     }
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width - 20; // 좌우 패딩 10씩 적용
//     final containerWidth = screenWidth / _length; // 아이템 너비도 조정
//     print('startingPos: $_buttonHide');
//     print(_buttonHide);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Container(
//         color: widget.backgroundColor,
//         height: widget.height,
//         child: Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.bottomCenter,
//           children: <Widget>[
//             Positioned(
//               bottom: -40 - (80.0 - widget.height),
//               left: Directionality.of(context) == TextDirection.rtl
//                   ? null
//                   : _pos * screenWidth,
//               right: Directionality.of(context) == TextDirection.rtl
//                   ? _pos * screenWidth
//                   : null,
//               width: containerWidth,
//               child: Center(
//                 child: Transform.translate(
//                   offset: Offset(
//                     0,
//                     -(1 - _buttonHide) * 80,
//                   ),
//                   child: Material(
//                     color: widget.buttonBackgroundColor ?? widget.color,
//                     type: MaterialType.circle,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: _icon,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0 - (80.0 - widget.height),
//               child: CustomPaint(
//                 painter: NavCustomPainter(
//                     _pos, _length, widget.color, Directionality.of(context)),
//                 child: Container(
//                   height: 80.0,
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0 - (80.0 - widget.height),
//               child: SizedBox(
//                   height: 80.0,
//                   child: Row(
//                       children: widget.items.map((item) {
//                         return NavButton(
//                           onTap: _buttonTap,
//                           position: _pos,
//                           length: _length,
//                           index: widget.items.indexOf(item),
//                           child: Center(child: item),
//                         );
//                       }).toList())),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void setPage(int index) {
//     _buttonTap(index);
//   }
//
//   void _buttonTap(int index) {
//     print('you here@@@@ $index');
//     if (!widget.letIndexChange(index)) {
//       return;
//     }
//     if (widget.onTap != null) {
//       widget.onTap!(index);
//     }
//     final newPosition = index / _length;
//     setState(() {
//       _startingPos = _pos;
//       _endingIndex = index;
//       _animationController.animateTo(newPosition,
//           duration: widget.animationDuration, curve: widget.animationCurve);
//     });
//   }
// }