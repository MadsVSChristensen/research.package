import 'package:flutter/material.dart';
import 'package:research_package_demo_app/user_demographics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'firebase/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepOrangeAccent),
      title: 'Research Package Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool fireBase = false;
  bool buttonReady = true;
  final FBAuth _auth = FBAuth();

  @override
  void initState() {
    super.initState();
    controlID();
  }

  void controlID() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('ID')) {
      sp.setString('ID', Uuid().v4());
      sp.setInt('attempts', 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Package Cognitive Testing beta"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Welcome to the beta-testing of cognitive tests in Research Package, developed by Mads & Simon",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(height: 50),
                    Text(
                      "If you have any issues or questions feel free to contact us.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Get started!",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserDemographicsPage()));
                  },
                ),
              ),
            ),

            //firebase button toggle. 
            /* Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                width: 60,
                height: 50,
                child: OutlineButton(
                  child: _getIcon(),
                  onPressed: () async {
                    if (buttonReady) {
                      if (fireBase) {
                        //if firebase is enabled, on click disables it.
                        setState(() {
                          fireBase = false;
                        });
                        await _auth.signOut();
                        print("sign out");
                      } else {
                        //enable firebase if not.
                        setState(() {
                          fireBase = true;
                        });
                        buttonReady =
                            false; //make button un-clickable while signing in
                        dynamic response = await _auth.anonSignIn();
                        buttonReady = true;
                        if (response == null) {
                          print('error');
                        } else {
                          print(response.uid);
                        }
                      }
                    }
                  },
                ),
              ),
              Text(
                'Tap to toggle database',
                style: TextStyle(fontSize: 16),
              ),
            ]), */
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Image.asset(
          "assets/images/cachet.png",
          height: 40,
        ),
      )),
    );
  }

  Widget _getIcon() {
    if (fireBase) {
      return Icon(Icons.check, size: 18);
    } else {
      return Icon(Icons.whatshot, size: 18);
    }
  }
}
