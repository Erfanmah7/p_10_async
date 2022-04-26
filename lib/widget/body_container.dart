import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {

 final VoidCallback onPressd;
 final String num;
  BodyContainer({required this.num,required this.onPressd});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: IconButton(
          onPressed: onPressd,
          icon: const Icon(
            Icons.cancel,
            color: Colors.red,
          ),
        ),
        trailing: Text(num),
      ),
    );
  }
}
