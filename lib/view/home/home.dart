import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/view/widgets/widget.dart';
import 'package:user_repository/user_repository.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../mystore.dart';

class HomePage extends MSStatefulWidget {
  HomePage({required this.user, Key? key}) : super(key: key);

  final User? user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MSState<HomePage> {
  var initialIndex = 0;
  var pageController = PageController();
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        initialIndex = pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // final pageView = PageView(
  //   controller: pageController,
  // );

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
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return ElevatedButton(
          child: Text('exit'),
          onPressed: () {
           // context.read<AuthBloc>().add(AuthLoggedOut());
          },
        );
      }),
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
          setState(() => initialIndex = index);
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
        selectedIndex: initialIndex,
        bottomPadding: 5,
        iconSize: 30,
      ),
    );
  }
}
