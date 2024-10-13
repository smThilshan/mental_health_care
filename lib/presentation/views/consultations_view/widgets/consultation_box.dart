import 'package:flutter/material.dart';

import '../../../../data/models/appointment_model.dart';

class ConsultationBox extends StatefulWidget {
  final List<AppointmentModel>appointmentModels;
  const ConsultationBox({Key? key, required this.appointmentModels}) : super(key: key);

  @override
  State<ConsultationBox> createState() => _ConsultationBoxState();
}

class _ConsultationBoxState extends State<ConsultationBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
    );
  }
}
