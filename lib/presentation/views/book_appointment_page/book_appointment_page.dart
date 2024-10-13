import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:mental_health/presentation/views/payment_page/payment_page.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_button.dart';
// Assuming 'CustomButtonWidget' is defined in your project

class BookAppointmentPage extends StatefulWidget {
  final String currentUserId;
  final String endUserId;
  final String endUserName;
  final String endUserEmail;
  final String endUserGender;
  final String special;
  BookAppointmentPage({required this.currentUserId, required this.endUserId, required this.endUserName, required this.endUserEmail, required this.endUserGender, required this.special});
  @override

  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();
  TimeOfDay? selectedTime;

  String? finalDate;
  String? finalTime;

  // For simplicity, define some time slots
  List<TimeOfDay> timeSlots = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    // Add more time slots as needed
  ];

  void _formatDateTime() {
    if (selectedDate != null) {
      finalDate = DateFormat('MM/dd/yyyy').format(selectedDate!);
    }

    if (selectedTime != null) {
      final hour = selectedTime!.hour;
      final minute = selectedTime!.minute;

      // Format hour to 12-hour format with leading zero if needed
      final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
      final formattedMinute = minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';

      finalTime = '$formattedHour:$formattedMinute $period';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Book Appointment', style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                ),),

                SizedBox(height: 20,),

                Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: focusedDate,
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          selectedDate = selectedDay;
                          this.focusedDate = focusedDay;
                        });
                      },
                      calendarFormat: CalendarFormat.month,
                    ),
                    if (selectedDate != null) ...[
                      Text('Select Time:'),
                      DropdownButton<TimeOfDay>(
                        value: selectedTime,
                        onChanged: (TimeOfDay? newValue) {
                          setState(() {
                            selectedTime = newValue;
                          });
                        },
                        items: timeSlots.map<DropdownMenuItem<TimeOfDay>>((TimeOfDay value) {
                          return DropdownMenuItem<TimeOfDay>(
                            value: value,
                            child: Text('${value.hour}:${value.minute.toString().padLeft(2, '0')}'),
                          );
                        }).toList(),
                      ),
                    ],

                    SizedBox(height: 20,),

                    CustomButtonWidget(text: 'Proceed', onPressed: (){
                      _formatDateTime();
                      print('Final date: $finalDate and final time: $finalTime');
                      if(finalDate != null && finalTime != null){
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => PaymentPage(date: finalDate!, time: finalTime!, currentUserId: widget.currentUserId, endUserId: widget.endUserId, endUserName: widget.endUserName),
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

                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
