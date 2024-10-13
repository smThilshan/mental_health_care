import 'package:flutter/material.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';

class OptionsButtonTemplate extends StatefulWidget {
  final VoidCallback onPressed;
  final String optionName;
  final IconData icon;
  const OptionsButtonTemplate({Key? key, required this.optionName, required this.icon, required this.onPressed}) : super(key: key);

  @override
  State<OptionsButtonTemplate> createState() => _OptionsButtonTemplateState();
}

class _OptionsButtonTemplateState extends State<OptionsButtonTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffdccaf3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Icon(widget.icon,color: Colors.deepPurple,),
              Text(widget.optionName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 10,),
              CustomButtonWidget(text: 'View', onPressed: (){
                widget.onPressed();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
