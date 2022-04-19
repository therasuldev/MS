import 'package:flutter/material.dart';
import 'package:ms/view/widgets/widget.dart';

class Home extends MSStatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('HOME CENTER')),
    );
  }
}
