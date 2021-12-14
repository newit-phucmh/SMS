import 'package:flutter/material.dart';
import 'package:sms/core/utils/constant.dart';


class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don’t have an account? ',
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16,
                color: Constants.kTextColor),
          ),
        ),
      ],
    );
  }
}
