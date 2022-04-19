import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_state.dart';
import 'package:ms/view/home/components/home.dart';
import 'package:ms/view/home/components/person.dart';
import 'package:ms/view/widgets/widget.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../mystore.dart';

class HomePage extends MSStatefulWidget {
  HomePage({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MSState<HomePage> {
  var selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
    //pageController.animateToPage(selectedIndex, duration: duration, curve: curve)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Onlayn Magaza'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        actions: [],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[Home(), Person()],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            Text('1'),
            Text('1'),
            Text('1'),
            Text('1'),
            Text('1'),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }

  Widget _bottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: WaterDropNavBar(
        onItemSelected: (int index) {
          setState(() => selectedIndex = index);
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad);
        },
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outline_rounded),
        ],
        waterDropColor: darkBlueColor,
        inactiveIconColor: lightBlueColor,
        selectedIndex: selectedIndex,
        bottomPadding: 5,
        iconSize: 30,
      ),
    );
  }
}
