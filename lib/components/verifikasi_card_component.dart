import 'package:flutter/material.dart';

class VerifikasiCard extends StatelessWidget {
  final String nama, nik, status;
  const VerifikasiCard({
    super.key,
    required this.nama,
    required this.nik,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 14,
          left: 23,
          right: 23,
          bottom: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Icon(Icons.account_circle, size: 42),
                Text(nama),
                Spacer(),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: status == "Pending" ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(status, style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("NIK"), Spacer(), Text(nik)],
            ),
          ],
        ),
      ),
    );
  }
}
