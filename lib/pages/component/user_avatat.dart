import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserAvatar extends StatelessWidget {
  final bool isNetwork;
  final String image;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  UserAvatar(
      {required this.isNetwork,
      required this.image,
      required this.onPressed,
      this.width = 30.0,
      this.height = 30.0,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: this.isNetwork
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/ic_public_account.png',
                  //预览图
                  fit: BoxFit.fitWidth,
                  image: image,
                  width: width,
                  height: height,
                )
              : Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
        ),
        onPressed: onPressed);
  }
}
