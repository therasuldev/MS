import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:ms/view/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends MSStatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends MSState<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Shimmer(
            period: const Duration(seconds: 3),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.grey, Colors.white]),
            child: DelayedDisplay(
              delay: Duration(milliseconds: 250),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(5),
                  height: 60,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 251, 241, 151),
                      borderRadius: BorderRadius.circular(15)),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    const double _radius = 50;
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: DelayedDisplay(
        delay: const Duration(milliseconds: 50),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 152, 190, 255),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    bottom: -_radius,
                    child: DelayedDisplay(
                      delay: Duration(milliseconds: 150),
                      child: CircleAvatar(
                        radius: _radius,
                        backgroundColor: Color.fromARGB(255, 185, 211, 255),
                        backgroundImage: AssetImage('assets/img/splash.png'),
                      ),
                    ))
              ]),
        ),
      ),
    );
  }
}
