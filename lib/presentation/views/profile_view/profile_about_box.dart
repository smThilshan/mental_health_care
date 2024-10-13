import 'package:flutter/material.dart';
import 'package:mental_health/presentation/views/edit_profile_page/edit_profile_page.dart';

class ProfileAboutBox extends StatelessWidget {
  final String gender;
  final String displayName;
  final String email;
  final String uid;
  const ProfileAboutBox({Key? key, required this.gender, required this.displayName, required this.email, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(radius: 35,backgroundColor: Colors.deepPurple,
          backgroundImage: gender=='male'?AssetImage('assets/images/man.png'):AssetImage('assets/images/woman.png'),
          ),
          SizedBox(width: 10,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(displayName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),

              Text(email,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          IconButton(onPressed: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => EditProfilePage(
                  currentUserId: uid,
                  displayName: displayName,
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );

          }, icon: Icon(Icons.edit_note_rounded)),
        ],
      ),
    );
  }
}
