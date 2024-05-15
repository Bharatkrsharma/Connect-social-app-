import 'package:connectapp/presentation/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect',
      theme: ThemeData.dark(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.blue,
            indicatorColor: Color(0xF8954CFF),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            labelTextStyle: MaterialStateProperty.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                    ? TextStyle(
                  color: Color(0xF8954CFF),
                )
                    : TextStyle()),
            /*iconTheme: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? IconThemeData(
                    size: 40,
                  )
                : IconThemeData()),*/
          )),
      home: AuthGate(),
      //SplashScreen(),
    );
  }
}
