import 'package:flutter/material.dart';
import 'package:sms/core/models/bottom_stateful_screen.dart';
import 'package:sms/screens/profile_screen/view/profile_screen.dart';
import 'package:sms/screens/qr_screen/view/qr_screen.dart';

class MainScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => MainScreen());
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainScreenState extends State<MainScreen> {
  late PageController pageController;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: _selectedIndex,
      keepPage: true,
    );
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenWidget(
      pageController: pageController,
      selectedIndex: _selectedIndex,
      bottomTapped: bottomTapped);
  }

}

class MainScreenWidget extends StatefulWidget{
  MainScreenWidget({
    required this.selectedIndex,
    required this.pageController,
    required this.bottomTapped
  });

  int selectedIndex;
  PageController pageController;
  Function bottomTapped;

  @override
  State<StatefulWidget> createState() => MainScreenWidgetState();
  }

class MainScreenWidgetState extends State<MainScreenWidget>{
  final List<BottomStatelessScreen> _screens = [];
  @override
  void initState() {
    // TODO: implement initState
    _screens.add(QRScreen());
    _screens.add(ProfileScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildScreenView(),
        bottomNavigationBar: _buildBottomNavigationBar());
  }

  Widget _buildScreenView() {
    return PageView(
      controller: widget.pageController,
      children: _screens,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildBottomNavigationBar() {
    var bottomNavigation = <BottomNavigationBarItem>[];
    for (var screen in _screens) {
      bottomNavigation.add(BottomNavigationBarItem(
          icon: screen.bottomBarIcon, label: screen.bottomBarTitle));
    }
    // Build bottom bar ui
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigation,
        currentIndex: widget.selectedIndex,
        onTap: widget.bottomTapped as Function(int),
      ),
    );
  }

}






