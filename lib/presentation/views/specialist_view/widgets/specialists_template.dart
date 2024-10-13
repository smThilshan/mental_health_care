import 'package:flutter/material.dart';

class SpecialistTemplate extends StatelessWidget {
  final String displayName;
  final String special;
  final VoidCallback onMessagePressed;
  final String gender;
  final VoidCallback onCalenderPressed;
  const SpecialistTemplate({Key? key, required this.displayName, required this.onMessagePressed, required this.special, required this.gender, required this.onCalenderPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Shadow color with opacity
        spreadRadius: 0, // Spread radius
        blurRadius: 10, // Blur radius
        offset: Offset(0, 3), // changes position of shadow, X and Y axis
      ),
      ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 100,
                  height: 100,
                  child: Image(
                    image: gender=='male'?AssetImage('assets/images/doctor_man.jpg'):AssetImage('assets/images/doctor_girl.jpg'),
                    fit: BoxFit.cover, // Zoom to fit the container without distortion
                  ),
                ),
              ],),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(displayName,style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.vaccines_sharp,size: 20,color: Colors.blueGrey,),
                        Text(special,style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                        ),),
                      ],
                    ),

                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.star,size: 20,color: Colors.orange,),
                        Text('4.7',style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                        ),),
                      ],
                    ),

                  ],
                ),
              ),
              IconButton(onPressed: (){
                onCalenderPressed();
              }, icon: Icon(Icons.calendar_month,color: Colors.deepPurpleAccent,),),
              IconButton(onPressed: (){
                onMessagePressed();
              }, icon: Icon(Icons.message,color: Colors.pink,),),
            ],
          ),
        ),
      ),
    );
  }
}
