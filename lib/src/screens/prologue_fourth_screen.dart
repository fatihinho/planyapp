import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planyapp/src/screens/home_screen.dart';
import 'package:planyapp/src/screens/prologue_third_screen.dart';

class PrologueFourthScreen extends StatefulWidget {
  @override
  _PrologueFourthScreenState createState() => _PrologueFourthScreenState();
}

class _PrologueFourthScreenState extends State<PrologueFourthScreen> {
  Route _navigateToThirdPrologue() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PrologueThirdScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _navigateToHomeScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  late ImageProvider _assetImage;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _assetImage = AssetImage('assets/prologue4.png');
    await precacheImage(_assetImage, context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                      width: size.width * 0.8,
                      child: Image(image: _assetImage)),
                ),
                Text('Alarm özelliği ile zamanı gelen tüm',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.farsan().fontFamily,
                        color: Colors.black)),
                Text('planlarından anında haberdar ol!',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.farsan().fontFamily,
                        color: Colors.black)),
                SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 8.0,
                        width: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 8.0,
                        width: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 8.0,
                        width: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 8.0,
                        width: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(_navigateToThirdPrologue());
                      },
                      child: Icon(Icons.arrow_left,
                          size: 100.0, color: Colors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(_navigateToHomeScreen());
                        },
                        child: Icon(Icons.arrow_right,
                            size: 100.0, color: Colors.black)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
