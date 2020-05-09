import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:research_package_demo_app/survey_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comments_page.dart';

class UserDemographicsPage extends StatefulWidget {
  @override
  _UserDemographicsPageState createState() => _UserDemographicsPageState();
}

class _UserDemographicsPageState extends State<UserDemographicsPage> {
  int age;
  String gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Text(
                    'Please enter your age and gender',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                //Divider(thickness: 2),
              ],
            ),
            //Container(height: 50),
            Column(
              children: <Widget>[
                Text(
                  'Age',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  age == null ? '---' : age.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: <Widget>[
                              Text('Select your age',
                                  style: TextStyle(fontSize: 30)),
                              Container(height: 10),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      itemCount: 100,
                                      //shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                age = index;
                                              });
                                              Navigator.pop(context);
                                            },
                                            color: Colors.blue.withOpacity(0.2),
                                            child: Text(index.toString(),
                                                style:
                                                    TextStyle(fontSize: 18)));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            //Container(height: 50),
            Column(
              children: <Widget>[
                Text(
                  'Gender',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  gender ?? '---',
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          //height: 300,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Center(
                                  child: Text('Select your gender',
                                      style: TextStyle(fontSize: 30))),
                              Container(height: 20),
                              FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      gender = 'Male';
                                    });
                                    Navigator.pop(context);
                                  },
                                  color: Colors.blue.withOpacity(0.2),
                                  child: Text('Male',
                                      style: TextStyle(fontSize: 25))),
                              FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      gender = 'Female';
                                    });
                                    Navigator.pop(context);
                                  },
                                  color: Colors.blue.withOpacity(0.2),
                                  child: Text('Female',
                                      style: TextStyle(fontSize: 25))),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            RaisedButton(
              onPressed: (age == null || gender == null)
                  ? null
                  : () async {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setString('gender', gender);
                      sp.setInt('age', age);
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SurveyPage()));
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentsPage()));
                      Navigator.pop(context);
                    },
              color: Colors.blue,
              child: Text('Finished'),
            )
          ],
        ),
      ),
    );
  }
}
