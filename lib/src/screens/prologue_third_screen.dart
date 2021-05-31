import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planyapp/src/screens/prologue_fourth_screen.dart';
import 'package:planyapp/src/screens/prologue_second_screen.dart';

class PrologueThirdScreen extends StatefulWidget {
  @override
  _PrologueThirdScreenState createState() => _PrologueThirdScreenState();
}

class _PrologueThirdScreenState extends State<PrologueThirdScreen> {
  Route _navigateToSecondPrologue() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PrologueSecondScreen(),
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

  Route _navigateToFourthPrologue() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PrologueFourthScreen(),
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
    _assetImage = AssetImage('assets/prologue3.png');
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
                Text('PlanyApp ile notlarını tut ve',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.farsan().fontFamily,
                        color: Colors.black)),
                Text('planlarını kolayca oluştur!',
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
                        color: Colors.black,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(_navigateToSecondPrologue());
                      },
                      child: Icon(Icons.arrow_left,
                          size: 100.0, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(_navigateToFourthPrologue());
                      },
                      child: Icon(Icons.arrow_right,
                          size: 100.0, color: Colors.black),
                    ),
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
