import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/widgets/custom_text_field.dart';

import '../../widgets/custom_button.dart';

class PaymentPage extends StatefulWidget {
  final String date;
  final String time;
  final String currentUserId;
  final String endUserId;
  final String endUserName;
  const PaymentPage({Key? key, required this.date, required this.time, required this.currentUserId,  required this.endUserId, required this.endUserName}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  TextEditingController nameTxtController = TextEditingController();
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Payments',style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                ),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Dr. ${widget.endUserName}',style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),

                      SizedBox(height: 6,),

                      Row(
                        children: <Widget>[
                          Text('Date: ',style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                          Text(widget.date,style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                        ],
                      ),

                      SizedBox(height: 6,),

                      Row(
                        children: <Widget>[
                          Text('Time: ',style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                          Text(widget.time,style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                        ],
                      ),

                      SizedBox(height: 30,),

                      Text('Enter your name:',style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),

                      CustomTextField(hint: 'How do you prefer to be called?..', textEditingController: nameTxtController),

                      SizedBox(height: 30,),

                      Text('Payment method:',style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.apple,size: 30,),
                                SizedBox(width: 10,),
                                Text('Apple Pay',style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                                Spacer(),
                                Icon(Icons.done),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),

                        ],
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.credit_card,size: 30,),
                                SizedBox(width: 10,),
                                Text('**** 2468',style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),

                        ],
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.credit_card,size: 30,),
                                SizedBox(width: 10,),
                                Text('**** 7580',style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),

                        ],
                      ),

                      Row(
                        children: <Widget>[
                          IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.deepPurple,),),
                          SizedBox(width: 10,),
                          Text('Add Card',style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                CustomButtonWidget(text: 'Confirm Appointment', onPressed: () async{
                  if (nameTxtController.text!=null && nameTxtController.text!='') {
                   await firebaseFeatures.createSharedAppointment(widget.endUserName, widget.endUserId, widget.currentUserId, nameTxtController.text, widget.date, widget.time);
                    Navigator.of(context).pop();
                  }
                  else{
                    print('Name cant be empty');
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
