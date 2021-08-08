import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:umkm_application/Coaching/ui/coaching.dart';
import 'package:umkm_application/Statistic/ui/statistic.dart';
import 'package:umkm_application/StoreDetail/ui/store_detail.dart';
import 'package:umkm_application/data/repositories/pref_repositories.dart';
import 'package:umkm_application/Const/const_color.dart';
import 'package:umkm_application/Event/ui/event_list.dart';
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
  late String _userID;

  Future<void> initPreference() async {
    _userID = await PrefRepository.getUserID() ?? '';
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    initPreference().whenComplete(() {
      setState(() {});
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(title: "Home Page"),
      EventPage(),
      CoachingPage(title: "Coaching"),
      Statistic(uid: _userID),
      StoreDetail(
        uid: _userID,
      )
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
        icon: Icon(Icons.people),
        title: ("Coaching"),
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
        icon: Icon(MdiIcons.faceProfile),
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
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 64,
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
