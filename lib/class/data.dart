import 'package:flutter/material.dart';

class LjaData{
  static final LjaData data = new LjaData._internal();

  factory LjaData() {
    return data;
  }

  LjaData._internal();

  init(){}

  var dataProduct= [];
  bool search = false;
}