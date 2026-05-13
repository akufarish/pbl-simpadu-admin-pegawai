import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';

Card ProfileCard(String nama, String email) {
  final request = DiceBearRequest(
    style: DiceBearStyle.initials,
    coreOptions: DiceBearCoreOptions(seed: nama),
  );

  Widget avatar = request.toImage(width: 80, height: 80);

  return Card(
    color: Colors.white,
    elevation: 3,
    child: Padding(
      padding: EdgeInsetsGeometry.fromLTRB(13, 17, 13, 17),
      child: Row(
        children: [
          // Icon(Icons.account_circle, size: 80),
          ClipOval(child: avatar),
          SizedBox(width: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(nama), Text(email)],
          ),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(Icons.edit, color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
