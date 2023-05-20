import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:habit_tracker/tabs/habit_tracker_tab.dart';
import 'package:habit_tracker/tabs/home_tab.dart';
import 'package:habit_tracker/tabs/settings_tab.dart';
import 'package:habit_tracker/theme/bloc/theme_bloc.dart';
import 'package:habit_tracker/widgets/tab_switcher_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TabSwitcherWidgetState> _leftSwitcherKey = GlobalKey();
  GlobalKey<TabSwitcherWidgetState> _rightSwitcherKey = GlobalKey();
  int _selectedTab = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabViewer(),
          TabSwitcherWidget(
            direction: Direction.left,
            key: _leftSwitcherKey,
          ),
          TabSwitcherWidget(
            direction: Direction.right,
            key: _rightSwitcherKey,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
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
