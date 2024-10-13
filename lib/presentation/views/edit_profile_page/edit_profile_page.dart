import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/bloc/dashboard_view/dashboard_view_bloc.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';
import 'package:mental_health/presentation/widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final String currentUserId;
  final String displayName;
  const EditProfilePage({super.key, required this.currentUserId, required this.displayName});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  FirebaseFeatures firbeaseFeatures = FirebaseFeatures();
  TextEditingController nameTxt = TextEditingController();
  @override

  Widget build(BuildContext context) {
    setState(() {
      nameTxt.text = widget.displayName;
      nameTxt.text=nameTxt.text;
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            
        Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text('Edit Profile',
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
    ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(hint: 'Display Name', textEditingController: nameTxt),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomButtonWidget(text: 'Save Changes', onPressed: ()async{
                await firbeaseFeatures.updateDisplayName(widget.currentUserId, nameTxt.text);
                BlocProvider.of<DashboardViewBloc>(context).add(ProfileClickEvent(currentUserId: widget.currentUserId));
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
