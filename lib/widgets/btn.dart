// Author: Digambar Chaudhari
//Author:  Bhavesh Patil
import 'package:flutter/material.dart';

class Btn {
  // Login page:
  Widget buildForgotBtn({
    required Function onClick,
  }) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: (() => onClick()),
        child: const Text(
          "forgot password ?",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 255),
          ),
        ),
      ),
    );
  }

  // Login page:
  Widget buildRegisterbtBtn({required Function onClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account?",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: (() => onClick()),
          child: Text(
            "register here",
            style: TextStyle(
              color: Color(0xFF0B6D3E),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoginBtn({required Function onClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: (() => onClick()),
          child: Text(
            "login here",
            style: TextStyle(
              color: Color(0xFF0B6D3E),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // Forgot Password Section
  Widget buildResendBtn({required Function onClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (() => onClick()),
          child: const Text(
            "Resend code",
            style: TextStyle(
              color: Colors.black54,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // card buttons v-home

  Widget buildCardButton(
    var url,
    var imageurl,
    var title,
  ) {
    return InkWell(
      onTap: (() => print(url)),
      child: Container(
        color: Color(0xFF0B6D3E),
        child: Card(
          child: Column(children: [
            Image.network(
              imageurl,
              height: 60,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(title)
          ]),
        ),
      ),
    );
  }
}
