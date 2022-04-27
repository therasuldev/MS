import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ms/view/home/components/home_page.dart';
import 'package:ms/view/home/components/profile_page.dart';
import 'package:ms/view/widgets/widget.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../mystore.dart';

class Home extends MSStatefulWidget {
  Home({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Home());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MSState<Home> {
  var initialIndex = 0;
  final pageController = PageController(initialPage: 0);
  final _pages = [HomePage(), Profile()];

  void pageChanged(int index) => setState(() => initialIndex = index);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: initialIndex == 0 ? _appBar() : null,
      body: PageView(
        onPageChanged: (value) => pageChanged(value),
        children: [_pages.elementAt(initialIndex)],
      ),
      drawer: const Drawer(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
          color: Colors.red,
        ),
        const CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage('assets/img/splash.png'),
        ),
        const Padding(padding: EdgeInsets.only(right: 10))
      ],
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
        onItemSelected: (int index) => pageChanged(index),
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
        selectedIndex: initialIndex,
        bottomPadding: 5,
        iconSize: 30,
      ),
    );
  }
}
