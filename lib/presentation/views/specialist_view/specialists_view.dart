import 'package:flutter/material.dart';
import 'package:mental_health/presentation/views/conversation_page/conversation_page.dart';
import 'package:mental_health/presentation/views/specialist_view/widgets/specialists_template.dart';
import 'package:mental_health/presentation/views/view_doctor_page/view_doctor_page.dart';

import '../../../data/models/doctor_model.dart';

class SpecialistView extends StatefulWidget {
  final List<DoctorModel> docModels;
  final String currentUserId;

  const SpecialistView(
      {Key? key, required this.docModels, required this.currentUserId})
      : super(key: key);

  @override
  State<SpecialistView> createState() => _SpecialistViewState();
}

class _SpecialistViewState extends State<SpecialistView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
          itemCount: widget.docModels.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SpecialistTemplate(
              onCalenderPressed: (){
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => ViewDoctorPage(
                      special: widget.docModels[index].special.toString(),
                      endUserName: widget.docModels[index].displayName.toString(),
                      endUserEmail: widget.docModels[index].email.toString(),
                      endUserGender: widget.docModels[index].gender.toString(),
                      currentUserId: widget.currentUserId,
                      endUserId: widget.docModels[index].uid.toString(),
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

              },
              gender: widget.docModels[index].gender.toString(),
              special: widget.docModels[index].special.toString(),
              displayName: widget.docModels[index].displayName.toString(),
              onMessagePressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ConversationPage(
                            endUserId: widget.docModels[index].uid.toString(),
                            currentUserId: widget.currentUserId,
                        endUserName: widget.docModels[index].displayName.toString(),
                        ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
              },
            );
          }),
    );
  }
}
