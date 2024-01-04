import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'di.dart';
import 'flavors.dart';
import 'my_app.dart';

Future<void> main() async {
  F.appFlavor = Flavor.production;

  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}
