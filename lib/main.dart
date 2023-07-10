import 'package:advertecha_test/core/locator.dart';
import 'package:advertecha_test/features/contact/presentation/pages/contact_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Advertecha test',
        home: ContactScreen());
  }
}
