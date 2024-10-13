import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFeatures {

  Future<User> signInUser(String email, String password) async {
    try {
      // Authenticate the user
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      String userId = user.uid;

      // Check if the user exists in the Firestore "users" collection
      var userDocument = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (!userDocument.exists) {
        // If the user document doesn't exist, throw an exception
        throw FirebaseAuthException(code: 'user-not-found-in-firestore', message: 'User not found in Firestore.');
      }

      // If everything is fine, return the authenticated user
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth exceptions
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }


  Future<User> signInDoctor(String email, String password) async {
    try {
      // Authenticate the user
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      String userId = user.uid;

      // Check if the user exists in the Firestore "doctors" collection
      var doctorDocument = await FirebaseFirestore.instance.collection('doctors').doc(userId).get();
      if (!doctorDocument.exists) {
        // If the user document doesn't exist in "doctors", throw an exception
        throw FirebaseAuthException(code: 'user-not-found-in-doctors', message: 'User not found in Firestore "doctors" collection.');
      }

      // If everything is fine, return the authenticated user
      return user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth exceptions
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }




  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Sign out failed: $e');
      // Handle sign out failure here
    }
  }




  Future<void> writeMessageToFirestore(String message, String currentUserId, String endUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Helper function to write a message
    Future<void> writeMessage(DocumentReference userDocRef, String otherUserId, String ownerId, String msg) async {
      // Ensure the user's document exists
      await userDocRef.set({}, SetOptions(merge: true));

      // Reference to the otherUser's document within the "users" collection
      DocumentReference otherUserDocRef = userDocRef.collection('users').doc(otherUserId);

      // Ensure the otherUser's document exists
      await otherUserDocRef.set({}, SetOptions(merge: true));

      // Reference to the "messages" collection within the otherUser's document
      CollectionReference messagesCollectionRef = otherUserDocRef.collection('messages');

      // Generate a random ID for the new message document
      String messageId = Random().nextInt(1000000).toString();

      // Get current date and time
      Timestamp currentTimeStamp = Timestamp.now();

      // Create data to be added to the new message document
      Map<String, dynamic> messageData = {
        'body': msg,
        'userId': ownerId,
        'time': currentTimeStamp,
      };

      // Add the message document to the "messages" collection
      await messagesCollectionRef.doc(messageId).set(messageData);
      print('Message written successfully to user $ownerId conversation with $otherUserId');
    }

    try {
      // Reference to the currentUser's document in the "conversations" collection
      DocumentReference currentUserDocRef = firestore.collection('conversations').doc(currentUserId);

      // Reference to the endUser's document in the "conversations" collection
      DocumentReference endUserDocRef = firestore.collection('conversations').doc(endUserId);

      // Write message to currentUser's document
      await writeMessage(currentUserDocRef, endUserId, currentUserId, message);

      // Write message to endUser's document
      await writeMessage(endUserDocRef, currentUserId, endUserId, message);
    } catch (e) {
      print('Error writing message to Firestore: $e');
    }
  }



  Future<void> registerPublicUserWithEmailAndPassword(
      String name,
      String email,
      String password,
      String confirmPassword,
      String gender,
      ) async {
    try {
      // Check if passwords match
      if (password != confirmPassword) {
        print('Passwords do not match');
        return;
      }

      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's unique ID
      String uid = userCredential.user!.uid;

      // Write user information to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'displayName': name,
        'email': email,
        'uid': uid,
        'gender':gender,
      });

      print('User registered successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      } else if (e.code == 'invalid-email') {
        print('The email address is invalid');
      } else {
        print('Error: $e');
      }
    } catch (e) {
      print('Error: $e');
    }
  }




  Future<void> registerDoctorWithEmailAndPassword(
      String name,
      String email,
      String password,
      String confirmPassword,
      String special,
      String gender,
      ) async {
    try {
      // Check if passwords match
      if (password != confirmPassword) {
        print('Passwords do not match');
        return;
      }

      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's unique ID
      String uid = userCredential.user!.uid;

      // Write doctor information to Firestore
      await FirebaseFirestore.instance.collection('doctors').doc(uid).set({
        'displayName': name,
        'email': email,
        'uid': uid,
        'special': special,
        'gender':gender,
      });

      print('Doctor registered successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      } else if (e.code == 'invalid-email') {
        print('The email address is invalid');
      } else {
        print('Error: $e');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> testFirestoreWrite(String currentUserId) async {
    try {
      CollectionReference testCollection = FirebaseFirestore.instance.collection('testCollection');

      // Hard-coded, correctly typed map
      Map<String, dynamic> testData = {
        'testKey': 'testValue',
        'testNumber': 123,
      };

      // Write the test data to Firestore
      await testCollection.doc(currentUserId).set(testData);

      print('Test write successful');
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }




  Future<void> writeMessage(String message, String currentUserId, String endUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Helper function to write a message
    Future<void> writeMessage(DocumentReference userDocRef, String otherUserId, String msg) async {
      // Ensure the user's document exists
      await userDocRef.set({}, SetOptions(merge: true));

      // Reference to the otherUser's document within the "users" subcollection
      DocumentReference otherUserDocRef = userDocRef.collection('users').doc(otherUserId);

      // Ensure the otherUser's document exists
      await otherUserDocRef.set({}, SetOptions(merge: true));

      // Reference to the "messages" collection within the otherUser's document
      CollectionReference messagesCollectionRef = otherUserDocRef.collection('messages');

      // Generate a random ID for the new message document
      String messageId = Random().nextInt(1000000).toString();

      // Get current date and time
      Timestamp currentTimeStamp = Timestamp.now();

      // Create data to be added to the new message document
      Map<String, dynamic> messageData = {
        'body': msg,
        'userId': currentUserId, // ID of the user who sent the message
        'time': currentTimeStamp, // Timestamp of when the message was sent
      };

      // Add the message document to the "messages" collection with a random ID
      await messagesCollectionRef.doc(messageId).set(messageData);
      print('Message successfully written to the "messages" subcollection for user $otherUserId from user $currentUserId');
    }

    try {
      // Reference to the currentUser's document in the "conversations" collection
      DocumentReference currentUserDocRef = firestore.collection('conversations').doc(currentUserId);

      // Reference to the endUser's document in the "conversations" collection
      DocumentReference endUserDocRef = firestore.collection('conversations').doc(endUserId);

      // Write message to currentUser's document targeting the endUser
      await writeMessage(currentUserDocRef, endUserId, message);

      // Write message to endUser's document targeting the currentUser
      await writeMessage(endUserDocRef, currentUserId, message);

      print('Message operation completed successfully.');
    } catch (e) {
      print('Error writing message to Firestore: $e');
    }
  }

///WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW////////

  Future<void> writeMessageForCurrentUser(String message, String currentUserId, String endUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Ensure the current user's document exists in the "conversations" collection and set the "uid" field
    DocumentReference currentUserDocRef = firestore.collection('conversations').doc(currentUserId);
    await currentUserDocRef.set({'uid': currentUserId}, SetOptions(merge: true));

    // Reference to the end user's document within the current user's "users" subcollection
    DocumentReference endUserInCurrentUserRef = currentUserDocRef.collection('users').doc(endUserId);

    // Ensure the end user's document exists within the current user's "users" subcollection and set the "uid" field
    await endUserInCurrentUserRef.set({'uid': endUserId}, SetOptions(merge: true));

    // Reference to the messages subcollection for the end user within the current user's "users" subcollection
    CollectionReference messagesCollectionRef = endUserInCurrentUserRef.collection('messages');

    String messageId = Random().nextInt(1000000).toString(); // Generate a random ID for the new message document
    Timestamp currentTimeStamp = Timestamp.now(); // Get current date and time

    Map<String, dynamic> messageData = {
      'body': message,
      'userId': currentUserId, // ID of the user who sent the message
      'time': currentTimeStamp, // Timestamp of when the message was sent
      'messageId': messageId, // Include the messageId in the document
    };

    // Add the message document to the "messages" subcollection
    await messagesCollectionRef.doc(messageId).set(messageData);
    print('Message successfully written for current user $currentUserId to user $endUserId with messageId $messageId');
  }


  Future<void> writeMessageForEndUser(String message, String currentUserId, String endUserId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Ensure the end user's document exists in the "conversations" collection and set the "uid" field
    DocumentReference endUserDocRef = firestore.collection('conversations').doc(endUserId);
    await endUserDocRef.set({'uid': endUserId}, SetOptions(merge: true));

    // Reference to the current user's document within the end user's "users" subcollection
    DocumentReference currentUserInEndUserRef = endUserDocRef.collection('users').doc(currentUserId);

    // Ensure the current user's document exists within the end user's "users" subcollection and set the "uid" field
    await currentUserInEndUserRef.set({'uid': currentUserId}, SetOptions(merge: true));

    // Reference to the messages subcollection for the current user within the end user's "users" subcollection
    CollectionReference messagesCollectionRef = currentUserInEndUserRef.collection('messages');

    String messageId = Random().nextInt(1000000).toString(); // Generate a random ID for the new message document
    Timestamp currentTimeStamp = Timestamp.now(); // Get current date and time

    Map<String, dynamic> messageData = {
      'body': message,
      'userId': currentUserId, // ID of the user who sent the message
      'time': currentTimeStamp, // Timestamp of when the message was sent
      'messageId': messageId, // Include the messageId in the document
    };

    // Add the message document to the "messages" subcollection
    await messagesCollectionRef.doc(messageId).set(messageData);
    print('Message successfully mirrored for end user $endUserId from user $currentUserId with messageId $messageId');
  }


  Future<void> deleteMessageForCurrentUser(String currentUserId, String endUserId, String messageId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Reference to the specific message document in the "messages" subcollection
      DocumentReference messageDocRef = firestore
          .collection('conversations')
          .doc(currentUserId)
          .collection('users')
          .doc(endUserId)
          .collection('messages')
          .doc(messageId);

      // Delete the message document
      await messageDocRef.delete();
      print('Message with messageId $messageId successfully deleted for current user $currentUserId.');
    } catch (e) {
      print('Error deleting message for current user: $e');
    }
  }


  Future<void> createSharedAppointment(
      String doctorName,
      String doctorId,
      String userId,
      String userCallingName,
      String date,
      String time) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Generate a shared random ID for the new appointment document
    String sharedEventId = Random().nextInt(1000000).toString();
    Timestamp appointmentTimestamp = Timestamp.now(); // Shared timestamp for record-keeping

    // Prepare shared appointment data
    Map<String, dynamic> appointmentData = {
      'doctorName': doctorName,
      'doctorId': doctorId,
      'userId': userId,
      'userCallingName': userCallingName,
      'date': date,
      'time': time,
      'eventId': sharedEventId,
      'created': appointmentTimestamp,
    };

    // From the current user's perspective
    DocumentReference currentUserDocRef = firestore.collection('appointments').doc(userId);
    DocumentReference doctorInCurrentUserRef = currentUserDocRef.collection('users').doc(doctorId);
    await doctorInCurrentUserRef.set({'uid': doctorId}, SetOptions(merge: true));
    CollectionReference eventsCollectionRefCurrentUser = doctorInCurrentUserRef.collection('events');
    await eventsCollectionRefCurrentUser.doc(sharedEventId).set(appointmentData);

    // From the doctor's perspective
    DocumentReference doctorDocRef = firestore.collection('appointments').doc(doctorId);
    DocumentReference currentUserInDoctorRef = doctorDocRef.collection('users').doc(userId);
    await currentUserInDoctorRef.set({'uid': userId}, SetOptions(merge: true));
    CollectionReference eventsCollectionRefDoctor = currentUserInDoctorRef.collection('events');
    await eventsCollectionRefDoctor.doc(sharedEventId).set(appointmentData);

    print('Appointment successfully created with eventId $sharedEventId');
  }



  Future<void> deleteEvent(String eventId, String currentUserId, String endUserId) async {
    try {
      // Delete from currentUserId's appointments collection
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(currentUserId)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((userDoc) async {
          await FirebaseFirestore.instance
              .collection('appointments')
              .doc(currentUserId)
              .collection('users')
              .doc(userDoc.id)
              .collection('events')
              .where('eventId', isEqualTo: eventId)
              .get()
              .then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              doc.reference.delete();
            });
          });
        });
      });

      // Delete from endUserId's appointments collection
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(endUserId)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((userDoc) async {
          await FirebaseFirestore.instance
              .collection('appointments')
              .doc(endUserId)
              .collection('users')
              .doc(userDoc.id)
              .collection('events')
              .where('eventId', isEqualTo: eventId)
              .get()
              .then((querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              doc.reference.delete();
            });
          });
        });
      });

      print('Event with eventId $eventId deleted successfully');
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  Future<void> updateDisplayName(String currentUID, String displayName) async {
    try {
      // Reference to the Firestore collection
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Update the displayName field within the document with currentUID
      await users.doc(currentUID).update({
        'displayName': displayName,
      });
      print('DisplayName updated successfully');
    } catch (e) {
      print('Error updating displayName: $e');
    }
  }

}