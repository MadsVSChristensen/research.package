import 'package:flutter/material.dart';

import 'firebase/auth.dart';
import 'survey_page.dart';

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
  final FBAuth _auth = FBAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Package Cognitive Testing Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
              child: Text(
                "Research Package offers a variety of cognitive assesment tests",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
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
                    "Survey",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SurveyPage()));
                  },
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                width: 60,
                height: 50,
                child: OutlineButton(
                  child: _getIcon(),
                  onPressed: () async {
                    if (fireBase) {
                      setState(() {
                        fireBase = false;
                      });
                      await _auth.signOut();
                      print("sign out");
                    } else {
                      setState(() {
                        fireBase = true;
                      });
                      dynamic response = await _auth.anonSignIn();
                      if (response == null) {
                        print('error');
                      } else {
                        print('dingdong');
                        print(response.uid);
                      }
                    }
                  },
                ),
              ),
              Text(
                'Tap to toggle database',
                style: TextStyle(fontSize: 16),
              ),
            ]),
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