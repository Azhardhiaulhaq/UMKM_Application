import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Home/ui/home.dart';

class BottomNavigation extends StatefulWidget {
  final BuildContext menuScreenContext;
  BottomNavigation({Key? key, required this.menuScreenContext})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(title: "Home Page"),
      Text(
        'Index 1: Event',
      ),
      Text(
        'Index 2: Statistic',
      ),
      Text(
        'Index 3: Profile',
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: ConstColor.sbmdarkBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.event),
        title: ("Event"),
        activeColorPrimary: ConstColor.sbmdarkBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.insert_chart_outlined),
        title: ("Statistic"),
        activeColorPrimary: ConstColor.sbmdarkBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.people),
        title: ("Profile"),
        activeColorPrimary: ConstColor.sbmdarkBlue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : 64,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 25.0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 6))
          ]),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property
    );
  }
}
