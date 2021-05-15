import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/planyapp.png',
                    width: size.width / 2.7,
                  ),
                  SizedBox(height: 16.0),
                  Text('PlanyApp',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.average().fontFamily,
                          color: Colors.cyan.shade900))
                ],
              ),
              WavyHeader(),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              WavyFooter(),
              CircleCyan(),
              CircleIndigo(),
            ],
          )
        ],
      ),
    );
  }
}

const List<Color> topGradients = [
  Colors.indigo,
  Colors.indigoAccent,
  Colors.cyan,
  Colors.cyanAccent
];

const List<Color> bottomGradients = [
  Colors.cyanAccent,
  Colors.cyan,
  Colors.indigoAccent,
  Colors.indigo
];

class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: topGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: size.height / 2.5,
      ),
    );
  }
}

class WavyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: bottomGradients,
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        height: size.height / 3,
      ),
    );
  }
}

class CircleCyan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-70.0, 90.0),
      child: Material(
        color: Colors.cyan,
        child: Padding(padding: EdgeInsets.all(120)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}

class CircleIndigo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, 210.0),
      child: Material(
        color: Colors.indigo,
        child: Padding(padding: EdgeInsets.all(140)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width / 7, size.height - 30);
    var firstEndPoint = Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
