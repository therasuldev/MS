import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_bloc.dart';
import 'package:ms/core/auth/app_bloc/app_event.dart';
import 'package:ms/core/auth/login_bloc/login_bloc.dart';
import 'package:ms/core/auth/login_bloc/login_state.dart';
import 'package:ms/core/repositories/user_repository.dart';
import 'package:ms/view/widgets/widget.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../mystore.dart';

class HomePage extends MSStatefulWidget {
  HomePage({required this.userRepository, required this.user, Key? key})
      : super(key: key);

  final UserRepository userRepository;
  final User? user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends MSState<HomePage> {
  //User? user;
  var selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: selectedIndex);
   // user = widget.user!;
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('item1'), value: 1),
              const PopupMenuItem(child: Text('item2'), value: 2),
              _popupMenuButton(context)
            ],
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.bookmark_rounded,
              size: 56,
              color: Colors.amber[400],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.favorite_rounded,
              size: 56,
              color: Colors.red[400],
            ),
          ),
        ],
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

  PopupMenuItem<int> _popupMenuButton(BuildContext context) {
    return PopupMenuItem(
      child: BlocProvider(
        create: (_) => LoginBloc(userRepository: widget.userRepository),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {},
          child: TextButton(
            child: const Text('Exit'),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLoggedOut());
            },
          ),
        ),
      ),
      value: 3,
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
