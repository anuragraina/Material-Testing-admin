import 'package:flutter/material.dart';

class TestType extends StatelessWidget {
  final String name;
  final String route;

  TestType({@required this.name, @required this.route});

  void selectTest(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTest(context),
      splashColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(15),
      child: Ink(
        width: 200,
        height: 100,
        child: Center(
            child: Text(
          name,
          style: TextStyle(
            color: route == null ? Colors.grey : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        )),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withAlpha(30),
              blurRadius: 5.0, // soften the shadow
              offset: Offset(
                3.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
        ),
      ),
    );
  }
}
