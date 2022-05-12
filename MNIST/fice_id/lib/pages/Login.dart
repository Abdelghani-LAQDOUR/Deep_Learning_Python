// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';


/*==================================> Classe LoginPage <============================ */
class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  /*--------- container topright---------*/
  Widget _contTopright() {
    return Positioned(
        right: 0,
        top: 0,
        child: ClipPath(
          clipper: _cliplogin(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple.shade200,
                    Colors.deepPurple.shade500
                  ]),
            ),
            // color: Colors.teal.shade600,
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 3,
          ),
        ));
  }

  /*--------- button se connecter ---------*/
  Widget _buttonConnecter() {
    return ElevatedButton(
      child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Center(
                  child: Text(
                "Let's go!",
                style: TextStyle(fontSize: 20),
              )),
              Padding(padding: EdgeInsets.all(8)),
              Icon(Icons.login_sharp)
            ],
          )),
      onPressed: () {
        Navigator.of(context).pushNamed("/home");
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple[500],
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  /*--------- Fonction Build ---------*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      _contTopright(),
                      Positioned(
                          left: 10,
                          right: 10,
                          top: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/splash_2.png',
                                  height: 300,
                                  width: 300,
                                ),
                                //Spacer(),
                                Text("Welcome to MNIST App",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "PatrickHand-Regular",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                        color: Colors.black87)),
                                Padding(padding: EdgeInsets.all(14)),
                                _buttonConnecter()
                              ],
                            ),
                          ))
                    ],
                  )))),
    );
  }
}

/*=============================> Classe cliplogin pour container Topright <===================== */
class _cliplogin extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(80, 0);
    var p1 = Offset(0, size.height * .3);
    var p2 = Offset(50, size.height * .50);
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    var p3 = Offset(size.width * .4, size.height * .35);
    var p4 = Offset(size.width * .65, size.height * .7);
    path.quadraticBezierTo(p3.dx, p3.dy, p4.dx, p4.dy);

    var p5 = Offset(size.width * .85, size.height + 20);
    var p6 = Offset(size.width, size.height - 25);
    path.quadraticBezierTo(p5.dx, p5.dy, p6.dx, p6.dy);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
