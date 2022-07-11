import 'package:blocks/main.dart';
import 'package:flutter/material.dart';
import 'block_widgets/all.dart';

final outputKey = GlobalKey<OutputState>();
final mainKey = GlobalKey<MainState>();
final homePageKey = GlobalKey<HomePageState>();
Map<String, int> variables = {};
Map<String, List<GlobalKey<VarBlockState>>> varmap = {};
