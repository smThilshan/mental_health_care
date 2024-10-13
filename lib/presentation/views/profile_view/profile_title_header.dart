import 'package:flutter/material.dart';

class ProfileTitleHeader extends StatelessWidget {
  const ProfileTitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text('Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight:FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Spacer(),
          //IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,)),
        ],
      ),
    );
  }
}
