import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wave/common/const/colors.dart';
import 'package:wave/country/view/search_country_screen.dart';
import 'package:wave/country/view/donate_countries_screen.dart';
import 'package:wave/map/view/global_map_screen.dart';
import 'package:wave/user/view/my_page_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;
  GlobalKey<CurvedNavigationBarState> navigationKey = GlobalKey();

  final screens = [
    GlobalMapScreen(),
    const DonateCountriesScreen(),
    const SearchCountriesScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // final items = List<Widget>.generate(4, (index) {
    //   String iconName =
    //       'tab${index + 1}${this.index == index ? 'On' : 'Off'}.svg';
    //   return SvgPicture.asset('assets/icons/$iconName');
    // });
    final items = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/tab1${index == 0 ? 'On' : 'Off'}.svg',
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/tab2${index == 1 ? 'On' : 'Off'}.svg',
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/tab3${index == 2 ? 'On' : 'Off'}.svg',
        ), label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/icons/tab4${index == 3 ? 'On' : 'Off'}.svg',
        ), label: '',
      ),
    ];
    return Scaffold(
      body: screens[index],
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: navigationKey, // key를 할당
      //   animationCurve: Curves.linearToEaseOut,
      //   animationDuration: const Duration(milliseconds: 800),
      //   backgroundColor: PRIMARY_BLUE_COLOR,
      //   buttonBackgroundColor:
      //       PRIMARY_BLUE_COLOR, // PRIMARY_COLOR를 적절한 색상 값으로 변경
      //   height: 55,
      //   index: index,
      //   items: items,
      //   color: Colors.black,
      //   onTap: (selectedIndex) {
      //     print(selectedIndex);
      //     setState(() {
      //       index = selectedIndex;
      //     });
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            index = selectedIndex;
          });
        },
        currentIndex: index,
        selectedItemColor: PRIMARY_BLUE_COLOR,
        unselectedItemColor: PRIMARY_BLUE_COLOR,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
