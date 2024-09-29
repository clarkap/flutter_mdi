import 'package:flutter/material.dart';
import 'package:flutter_mdi/core/mdi_application.dart';
import 'package:flutter_mdi/core/window_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultWindowManager(
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Flutter Window Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true,
              brightness: Brightness.light),
          home: Scaffold(
              appBar: AppBar(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        String id = DefaultWindowManager.of(context)
                            .createWindow(build: (_) {
                          return Container( color: Colors.green,);
                        });
                      },
                      child: const Text("New +"))
                ],
              ),
              body: const MDIApplication()),
        ),
      ),
    );
  }
}
