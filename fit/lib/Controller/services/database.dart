import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  // Create a DatabaseService Object in the main code to be able to call any of these functions
  // Also, define Firestore instance in main code using
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // This will allow you to create document and collection references in main code

  //Constructor
  DatabaseService();

  // In main code, put data to write in the form of Map<String, dynamic>
  // Also, define collection reference in the main code and call DatabaseService.writeNewDocument(colRef, map)
  // Write new document writes new document in collection, but we are unable to name the document
  Future<void> writeNewDocument(CollectionReference colRef, Map map) async {
    return colRef.add(map)
        .then((value) => print("Document written"))
        .catchError((error) => print("Failed to write document: $error"));
  }

  // In main code, put data to write in the form of Map<String, dynamic>
  // Also, define document reference in the main code and call DatabaseService.updateDocument(docRef, map)
  // Calling set with an id that already exists on the collection will replace all the document data if update is false.
  // Assign update as true, and this will merge the existing document with the data passed into the set():
  Future<void> updateDocument(DocumentReference docRef, Map map, bool update) async {
    return docRef.set(map, SetOptions(merge: update))
        .then((value) => print("Document written"))
        .catchError((error) => print("Failed to write document: $error"));
  }

  // Call this function to get the document, define document reference in the main code
  // Function will return the document snapshot in the form of Map<String, dynamic>
  Future<void> getDocument(DocumentReference docRef) async {
    return docRef.get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // Call this function to get a field from a document snapshot, works the same way as getDocument,
  // but there is an attribute fieldName, which has datatype List<String>
  Future<void> getField(DocumentReference docRef, List<String> fieldName) async {
    return docRef.get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic field = documentSnapshot.get(FieldPath(fieldName));
          print('Field: ' + field);
        } on StateError catch (e) {
          print('Field does not exist in this document snapshot');
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // Call this function to get the collection, define collection reference in the main code
  // Function will return the query snapshot, call docs to get a list of the document names
  Future<void> getCollection(CollectionReference colRef) async {
    return colRef.get()
        .then((QuerySnapshot querySnapshot) {
        List<QueryDocumentSnapshot> documents = querySnapshot.docs;
        print('List of Documents: $documents');
      });
  }

  Future<void> deleteDocument(DocumentReference docRef) async {
    return docRef.delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}


