import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String name;
  final String route;

  TestCard({@required this.name, @required this.route});

  void selectTest(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
      elevation: 5,
      child: InkWell(
        onTap: () => selectTest(context),
        splashColor: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(4),
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(
              color: route == null ? Colors.grey : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
