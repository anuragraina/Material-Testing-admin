import 'package:flutter/material.dart';
// import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSquareCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}

//This is a demo loader
// class Loader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FadingText('Loading...'),
//       ),
//       backgroundColor: Theme.of(context).backgroundColor,
//     );
//   }
// }
