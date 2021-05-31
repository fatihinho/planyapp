import 'package:flutter/material.dart';
import 'package:planyapp/src/screens/home_screen.dart';
import 'package:planyapp/src/services/auth_service.dart';
import 'package:planyapp/src/services/firestore_service.dart';
import 'package:planyapp/src/widgets/loginscreen_input_widget.dart';

const List<Color> _startingGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

Widget _roundedRectButton(String title, List<Color> gradient) {
  return Builder(builder: (context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: [
          Container(
            alignment: Alignment.center,
            width: size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          ),
        ],
      ),
    );
  });
}

class LoginScreenWidget extends StatelessWidget {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: size.height / 2.3),
        ),
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 64.0),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    LoginScreenInput(30.0, 0.0, _nameController),
                    Padding(
                        padding: EdgeInsets.only(right: 50.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Text(
                                'Devam etmek için isminizi giriniz...',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0),
                              ),
                            )),
                            Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  gradient: LinearGradient(
                                      colors: _startingGradients,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 40.0,
                                  color: Colors.white,
                                )),
                          ],
                        ))
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
            ),
            GestureDetector(
                onTap: () {
                  if (_nameController.text.isNotEmpty) {
                    _authService.signInAnonymous().then((value) => {
                          if (value)
                            {
                              _firestoreService
                                  .setUserName(_nameController.text),
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()),
                                  (route) => false)
                            }
                        });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text('İsminizi Giriniz!')));
                  }
                },
                child:
                    _roundedRectButton("Kullanmaya Başla", _startingGradients)),
          ],
        )
      ],
    );
  }
}
