import 'package:flutter/material.dart';

class AuthPageImage extends StatelessWidget {
  final String image;

  const AuthPageImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: deviceSize.height * 0.23,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image)),
        ),
      ),
    );
  }
}
