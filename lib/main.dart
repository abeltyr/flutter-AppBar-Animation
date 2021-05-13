import 'package:skeleton/Providers/interaction/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton/Screens/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String initialRoute = "/";
  final Map<String, Widget Function(BuildContext)> routes = {
    '/': (ctx) => IndexScreen(),
  };
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: InteractionProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: initialRoute,
        routes: routes,
      ),
    );
  }
}
