import 'package:flutter/material.dart';
import 'intl.dart';

import '../utils/logger.dart';

class MS {
  static final MS _singleton = MS._internal();

  final Map<String, dynamic> instances = {};

  factory MS() => _singleton;

  MS._internal() {
    Log.v('${runtimeType.toString()} instance created');
  }

  set intl(Intl intl) => instances['intl'] = intl;
  Intl get intl => instances['intl'];

  String fmt(BuildContext context, String key, [List? args]) {
    return intl.of(context)?.fmt(key, args) ?? '';
  }
}

@immutable
abstract class MSModel {
  const MSModel();

  const MSModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

typedef ItemCreator<S> = S Function();
