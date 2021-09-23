import 'package:flutter/material.dart';
import '../constants.dart' show Constants, AppColors;

class FullWidthButton extends StatelessWidget {
  static const HORIZONTAL_PADDING = 20.0;
  static const VERTICAL_PADDING = 13.0;

  const FullWidthButton({
    required this.title,
    required this.iconPath,
    required this.onPressed,
    this.showDivider: false,
  });

  final String title;
  final String iconPath;
  final bool showDivider;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final pureButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          iconPath,
          width: Constants.FullWidthIconButtonIconSize,
          height: Constants.FullWidthIconButtonIconSize,
        ),
        SizedBox(width: HORIZONTAL_PADDING),
        Expanded(
          child: Text(title),
        ),
        Icon(
          const IconData(
            0xe664,
            fontFamily: Constants.IconFontFamily,
          ),
          size: 22.0,
          color: AppColors.TabIconNormal,
        ),
      ],
    );

    final borderButton = Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: AppColors.DividerColor, width: Constants.DividerWidth)),
      ),
      padding: EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: HORIZONTAL_PADDING,
            right: HORIZONTAL_PADDING,
            top: VERTICAL_PADDING,
            bottom: showDivider ? 0.0 : VERTICAL_PADDING),
        color: Colors.white,
        child: showDivider ? borderButton : pureButton,
      ),
    );
  }
}
