import 'package:flutter/material.dart';

import '../../core/app/ms.dart';


abstract class MSStatelessWidget extends StatelessWidget {
  MSStatelessWidget({Key? key}) : super(key: key);
  final ms = MS();
}

abstract class MSStatefulWidget extends StatefulWidget {
  MSStatefulWidget({Key? key}) : super(key: key);
  final ms = MS();
}

abstract class MSState<B extends MSStatefulWidget> extends State<B> {
  final ms = MS();
}
