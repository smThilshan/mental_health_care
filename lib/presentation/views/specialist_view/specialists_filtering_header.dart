import 'package:flutter/material.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';

class SpecialistsFilteringHeader extends StatefulWidget {
  const SpecialistsFilteringHeader({Key? key}) : super(key: key);

  @override
  State<SpecialistsFilteringHeader> createState() => _SpecialistsFilteringHeaderState();
}

class _SpecialistsFilteringHeaderState extends State<SpecialistsFilteringHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50, // Adjust as needed
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomButtonWidget(text: 'General',onPressed: (){}),
              ),
              SizedBox(width: 10,),
              CustomButtonWidget(text: 'Gestalt',onPressed: (){}),
              SizedBox(width: 10,),
              CustomButtonWidget(text: 'Counsellor',onPressed: (){}),
              SizedBox(width: 10,),
              CustomButtonWidget(text: 'Coaching',onPressed: (){}),
            ]
        ),
      ),
    );
  }
}
