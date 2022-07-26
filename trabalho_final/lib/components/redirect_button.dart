import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedirectButton extends StatelessWidget {
  const RedirectButton({Key? key, required this.title, required this.target}) : super(key: key);

  final String title;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => target),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              const Icon(
                CupertinoIcons.forward,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
