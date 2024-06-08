import 'package:flutter/material.dart';

class LandingWidget extends StatelessWidget {
  final String title;
  const LandingWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(50),
            bottomStart: Radius.circular(50),
          )),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      )),
    );
  }
}
