import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/core/utils/constant.dart';

class UserButtonWidget extends StatelessWidget {
  const UserButtonWidget({required this.title,
    required this.leading,
    required this.onTap,
    required this.trailing});

  final String title;
  final void Function() onTap;
  final Icon leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
                color: Constants.cSecondTextColor, width: 1)),
        child: Ink(
          child: InkWell(
              splashColor: Constants.cPlashColor.withOpacity(0.5),
              highlightColor: Constants.cPlashColor.withOpacity(0.4),
              child: ListTile(
                leading: leading,
                title: Text(title),
                trailing: trailing,
              ),
              onTap: onTap),
        ),
      ),
    );
  }
}
