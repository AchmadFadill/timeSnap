import 'package:timesnap/core/di/dependency.dart';
import 'package:timesnap/core/widget/error_app_widget.dart';
import 'package:timesnap/core/widget/loading_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

void main() async {
  await initializeDateFormatting('id', null);
  await initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ErrorAppWidget(
          descripton: "Error requets API",
          onPressDefaultButton: () {
            print("refesh button on click");
          },
          alternatifButton:  FilledButton(
            child: Text("Print"),
            onPressed: () {
              print("print sekarang");
            }, 
          ),
        ),
      ),
    );
  }
}