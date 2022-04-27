import 'package:flutter/material.dart';
import 'package:ms/view/widgets/widget.dart';

class HomePage extends MSStatefulWidget {
   HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends MSState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: 70,
        color: Colors.brown,
      ),
    );
  }
}