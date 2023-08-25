import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:comics_app/src/routes/routes.dart';
import 'package:comics_app/src/providers/comic_provider.dart';

// void main() => runApp(const AppState());
Future main() async {
  await dotenv.load(fileName: "assets/.env"); // mergeWith optional, you can include Platform.environment for Mobile/Desktop app

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComicsProvider(), lazy: false),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComicApp',
      initialRoute: '/',
      routes: getAppRoutes(),
      theme: ThemeData.dark(),
    );
  }
}
