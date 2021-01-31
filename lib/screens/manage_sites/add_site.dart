import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../services/database.dart';

class AddSite extends StatefulWidget {
  @override
  _AddSiteState createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final DatabaseService _db = DatabaseService();

  var _formKey = GlobalKey<FormState>();

  String name = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: true,

      /// your body here
      customBody: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
    return Padding(
      padding: EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 325,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter site name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() => name = value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter site name',
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              width: 325,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter location';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() => location = value);
                },
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  errorStyle: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  'Add Site',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await pr.show();
                    dynamic result = await _db.addSite(name, location);
                    print(result);
                    await pr.hide();
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
