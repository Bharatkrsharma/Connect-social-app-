import 'package:connectapp/presentation/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => SignUp(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/image.png'),width: 180,height: 180,),
            /*Icon(
              Icons.edit,
              size: 80,
              color: Colors.white,
            ),*/
            //SizedBox(height: 20),
            //Image(image: AssetImage('assets/instagram.png'),width: 160,height: 80,),
            /*Text("Instagram Clone",style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 32,
            ),
            ),*/
          ],
        ),
      ),
    );
  }
}
