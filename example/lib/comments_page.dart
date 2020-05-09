import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/database.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Any additional comments?')),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onSubmitted: (s) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                        hintMaxLines: 3,
                        hintText:
                            'Enter any additional comments you have. All feedback is greatly appreciated!'),
                    maxLines: null,
                    expands: true,
                    controller: controller,
                  ),
                ),
                FlatButton(
                  color: Colors.blue.withOpacity(0.2),
                  child: Text('Finish'),
                  onPressed: () async {
                    DBService().addComments(controller.text);
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    int attempt = sp.getInt('attempts');
                    attempt++;
                    sp.setInt('attempts', attempt);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
