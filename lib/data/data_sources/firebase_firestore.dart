import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class FirestoreDataSource {

  Future<List<MessageModel>> getMessageModelList(String currentUserID, String endUserID) async {
    List<MessageModel> messagesList = [];

    try {
      // Reference to the currentUser's document in the "conversations" collection
      DocumentReference currentUserDocRef = FirebaseFirestore.instance.collection('conversations').doc(currentUserID);

      // Reference to the endUser's document within the "users" collection
      DocumentReference endUserDocRef = currentUserDocRef.collection('users').doc(endUserID);

      // Query the "messages" collection within the endUser's document
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await endUserDocRef.collection('messages').get();

      // Map each document to a MessageModel instance
      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
        // Extract document data
        Map<String, dynamic> data = docSnapshot.data();

        // Create MessageModel instance
        MessageModel message = MessageModel(
          body: data['body'],
          userId: data['userId'],
          currentUser: data['currentUser'],
          time: data['time'].toDate(), // Assuming 'time' field is a Firestore Timestamp
        );

        // Add MessageModel instance to the list
        messagesList.add(message);
      }
    } catch (e) {
      print('Error fetching messages: $e');
      // Handle error
    }

    return messagesList;
  }





  Future<List<DoctorModel>> getDoctorModelList() async {
    List<DoctorModel> doctorsList = [];
    try {
      // Get all documents from the "doctors" collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      // Map each document to a DoctorModel instance
      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
          in querySnapshot.docs) {
        // Extract document data
        Map<String, dynamic> data = docSnapshot.data();

        // Create DoctorModel instance using fromJson method
        DoctorModel doctor = DoctorModel.fromJson(data);

        // Add DoctorModel instance to the list
        doctorsList.add(doctor);
      }
    } catch (e) {
      print('Error fetching doctors: $e');
      // Handle error
    }
    return doctorsList;
  }




  Stream<List<MessageModel>> getMessageModelStream(String currentUserID, String endUserID) {
    try {
      // Reference to the currentUser's document in the "conversations" collection
      DocumentReference currentUserDocRef = FirebaseFirestore.instance.collection('conversations').doc(currentUserID);

      // Reference to the endUser's document within the "users" collection
      DocumentReference endUserDocRef = currentUserDocRef.collection('users').doc(endUserID);

      // Stream the "messages" collection within the endUser's document
      return endUserDocRef.collection('messages')
          .orderBy('time', descending: false) // Sort messages by 'time' in descending order
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList());
    } catch (e) {
      print('Error fetching messages: $e');
      // Handle error
      return Stream.value([]); // Return an empty list in case of error
    }
  }


  Future<List<UserModel>> getUsersFromConversation(String currentUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<UserModel> userList = [];

    try {
      // Reference to the "users" subcollection within the current user's "conversations" document
      CollectionReference usersRef = firestore.collection('conversations').doc(currentUserId).collection('users');

      // Fetch all documents (user IDs) from the "users" subcollection
      QuerySnapshot usersSnapshot = await usersRef.get();

      print('Found ${usersSnapshot.docs.length} user(s) in conversation'); // Debug statement

      // For each document in the "users" subcollection
      for (var doc in usersSnapshot.docs) {
        String userId = doc.id; // The document ID is the user's ID
        print('Processing user: $userId'); // Debug statement

        // Fetch the corresponding user details from the main "users" collection
        DocumentSnapshot userSnapshot = await firestore.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          print('Found user details for $userId'); // Debug statement
          UserModel user = UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
          userList.add(user);
        } else {
          print('No details found for user $userId'); // Debug statement
        }
      }

      return userList; // Return the list of UserModel instances
    } catch (e) {
      print('Error retrieving users from conversation: $e');
      return []; // Return an empty list in case of error
    }
  }



  Future<List<DoctorModel>> getDoctorsFromConversation(String currentUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<DoctorModel> userList = [];

    try {
      // Reference to the "users" subcollection within the current user's "conversations" document
      CollectionReference usersRef = firestore.collection('conversations').doc(currentUserId).collection('users');

      // Fetch all documents (user IDs) from the "users" subcollection
      QuerySnapshot usersSnapshot = await usersRef.get();

      print('Found ${usersSnapshot.docs.length} user(s) in conversation'); // Debug statement

      // For each document in the "users" subcollection
      for (var doc in usersSnapshot.docs) {
        String userId = doc.id; // The document ID is the user's ID
        print('Processing user: $userId'); // Debug statement

        // Fetch the corresponding user details from the main "users" collection
        DocumentSnapshot userSnapshot = await firestore.collection('doctors').doc(userId).get();

        if (userSnapshot.exists) {
          print('Found user details for $userId'); // Debug statement
          DoctorModel doctor = DoctorModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
          userList.add(doctor);
        } else {
          print('No details found for user $userId'); // Debug statement
        }
      }

      return userList; // Return the list of UserModel instances
    } catch (e) {
      print('Error retrieving users from conversation: $e');
      return []; // Return an empty list in case of error
    }
  }



  Future<UserModel?> getUserModel(String currentUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Attempt to fetch the user document from Firestore
      DocumentSnapshot userDocSnapshot = await firestore.collection('users').doc(currentUserId).get();

      if (userDocSnapshot.exists) {
        // If the document exists, convert the document data to a UserModel
        UserModel userModel = UserModel.fromJson(userDocSnapshot.data() as Map<String, dynamic>);
        return userModel;
      } else {
        // If the document does not exist, return null or handle as needed
        print('User document with id $currentUserId does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user document: $e');
      return null; // Return null or handle the error as needed
    }
  }


  Future<List<AppointmentModel>> fetchAppointments(String currentUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<AppointmentModel> appointments = [];

    // Reference to the current user's document within the "appointments" collection
    DocumentReference currentUserDocRef = firestore.collection('appointments').doc(currentUserId);

    // Fetch the "users" subcollection documents (doctors)
    QuerySnapshot usersSnapshot = await currentUserDocRef.collection('users').get();

    // Iterate through each doctor document
    for (DocumentSnapshot userDoc in usersSnapshot.docs) {
      // Reference to the "events" subcollection for each doctor
      CollectionReference eventsCollectionRef = userDoc.reference.collection('events');

      // Fetch all events documents for the doctor
      QuerySnapshot eventsSnapshot = await eventsCollectionRef.get();

      // Map each event document to an AppointmentModel and add it to the list
      appointments.addAll(eventsSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return AppointmentModel.fromJson(data);
      }).toList());
    }

    return appointments;
  }


}
