import 'package:e_services_fyp/res/colors.dart';
import 'package:flutter/material.dart';

import '../../../res/text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final IconData iconData;
  final Color icnColor;
  final String title;
  final VoidCallback onPress;

  const ListTileWidget({
    super.key,
    required this.iconData,
    this.icnColor = AppColors.primaryColor,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // style: ListTileStyle.list,
      // tileColor: AppColors.bgColor,
      leading: Icon(
        iconData,
        color: AppColors.iconsColor,
        size: 25,
      ),
      title: TextWidget(
        title: title,
        textColor: Colors.black,

      ),
      onTap: onPress,
    );
  }
}