import 'package:craft_cuts_mobile/common/presentation/craft_cuts_app/craft_cuts_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru');
  runApp(
    CraftCutsApp(),
  );
}
