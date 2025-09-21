import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/tabs/habit_tracker_tab.dart';
import 'package:habit_tracker/tabs/home_tab.dart';
import 'package:habit_tracker/tabs/settings_tab.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';
import 'package:habit_tracker/widgets/home_tab/route_animation.dart';
import 'package:habit_tracker/widgets/tab_seperator_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
  static const tabSwitcherHeight = 110.0;
}

class HomeScreenState extends State<HomeScreen> {
  static GlobalKey<RouteAnimationState> routeAnimationKey = GlobalKey();
  GlobalKey<TabSeperatorAnimationWidgetState> _leftSwitcherKey = GlobalKey();
  GlobalKey<TabSeperatorAnimationWidgetState> _rightSwitcherKey = GlobalKey();
  int _selectedTab = 0;
  bool _notificationsEnabled = false;
  int id = 0;

  Future<void> _requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? grantedNotificationPermission =
        await androidImplementation?.requestNotificationsPermission();
    setState(() {
      _notificationsEnabled = grantedNotificationPermission ?? false;
    });
  }

  @override
  void initState() {
    //For Notifications
    _requestPermission();
    super.initState();
  }

  Widget _tabViewer() {
    switch (_selectedTab) {
      case 0:
        return HomeTab();
      case 1:
        return HabitTrackerTab();
      case 2:
        return SettingsTab();
      default:
        return Placeholder();
    }
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabViewer(),
          TabSeperatorAnimationWidget(
            direction: Direction.left,
            key: _leftSwitcherKey,
          ),
          TabSeperatorAnimationWidget(
            direction: Direction.right,
            key: _rightSwitcherKey,
          ),
          RouteAnimation(
              key: routeAnimationKey,
              startingPoint: Point(20, HomeScreen.tabSwitcherHeight)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: HomeScreen.tabSwitcherHeight,
              color: Theme.of(context).scaffoldBackgroundColor,
              // color: Colors.amber,
              padding: const EdgeInsets.only(top: 16),
              child: SafeArea(
                top: false,
                child: GNav(
                  color: Theme.of(context).iconTheme.color,
                  activeColor: context.read<ThemeBloc>().state.isNightMode
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColorDark,
                  tabMargin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  gap: 10,
                  padding: const EdgeInsets.all(16),
                  tabActiveBorder:
                      Border.all(color: Theme.of(context).dividerColor),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: "Home",
                    ),
                    GButton(
                      icon: Icons.note_alt,
                      text: "Tracker",
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: "Settings",
                    )
                  ],
                  onTabChange: (index) async {
                    if (index > _selectedTab) {
                      await _rightSwitcherKey.currentState!
                          .startFirstAnimation();
                      setState(() {
                        _selectedTab = index;
                      });
                      await Future.delayed(const Duration(milliseconds: 100));
                      _rightSwitcherKey.currentState!.startSecondAnimation();
                    } else if (index < _selectedTab) {
                      await _leftSwitcherKey.currentState!
                          .startFirstAnimation();
                      setState(() {
                        _selectedTab = index;
                      });
                      await Future.delayed(const Duration(milliseconds: 100));
                      await _leftSwitcherKey.currentState!
                          .startSecondAnimation();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
