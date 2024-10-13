import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/appointment_model.dart';

class SharedPreferencesRepo {


  Future<void> saveAppointmentToSharedPreferences(AppointmentModel appointment) async {
    try {
      // Get the existing list of appointments from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final List<String> existingAppointments = prefs.getStringList(
          'appointments') ?? [];

      // Serialize the new appointment to JSON
      final String appointmentJson = jsonEncode(appointment.toJson());

      // Add the new appointment JSON string to the existing list
      existingAppointments.add(appointmentJson);

      // Store the updated list of appointments in SharedPreferences
      await prefs.setStringList('appointments', existingAppointments);

      print('Appointment saved to SharedPreferences');
    } catch (e) {
      print('Error saving appointment to SharedPreferences: $e');
    }
  }



  Future<List<AppointmentModel>> getAllAppointmentsFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> appointmentsJson = prefs.getStringList('appointments') ?? [];
      List<AppointmentModel> appointments = [];

      for (String appointmentJson in appointmentsJson) {
        final Map<String, dynamic> appointmentMap = jsonDecode(appointmentJson);
        final AppointmentModel appointment = AppointmentModel.fromJson(appointmentMap);
        appointments.add(appointment);
      }

      return appointments;
    } catch (e) {
      print('Error getting appointments from SharedPreferences: $e');
      return [];
    }
  }

  Future<void> deleteAppointmentFromSharedPreferences(String eventId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> appointmentsJson = prefs.getStringList('appointments') ?? [];

      // Remove the appointment with the specified eventId
      appointmentsJson.removeWhere((appointmentJson) {
        final Map<String, dynamic> appointmentMap = jsonDecode(appointmentJson);
        final AppointmentModel appointment = AppointmentModel.fromJson(appointmentMap);
        return appointment.eventId == eventId;
      });

      // Save the updated list of appointments in SharedPreferences
      await prefs.setStringList('appointments', appointmentsJson);
      print('Appointment with eventId: $eventId deleted successfully');
    } catch (e) {
      print('Error deleting appointment from SharedPreferences: $e');
    }
  }

}