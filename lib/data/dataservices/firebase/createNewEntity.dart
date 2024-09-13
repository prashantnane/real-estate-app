
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/generic/api_response.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> createEntityRecord<T>(
    String collectionName,
    T data,
    ) async {
  try {
    DocumentReference<Map<String, dynamic>> documentRef = await _firestore.collection(collectionName).add(data as Map<String,dynamic>);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();
    if (documentSnapshot.exists) {
      print("This is documentSnapshot at createEntity : ${documentSnapshot.data()}");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "Data Created Successfully", data: documentSnapshot);
    } else {
      print("Not able to create it");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "Failed to create data", data: null);
    }
  } catch (e) {
    print('Error creating entity record: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "error", message: "Error creating entity record", data: null);
  }
}

Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> createEntityRecordWithID<T>(
    String collectionName,
    String id,
    T data,
    ) async {
  try {
    final documentRef = FirebaseFirestore.instance.collection(collectionName).doc(id);
    // DocumentReference<Map<String, dynamic>> documentRef = await _firestore.collection(collectionName).add(data as Map<String,dynamic>);
    await documentRef.set(data as Map<String,dynamic>);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentRef.get();
    if (documentSnapshot.exists) {
      print("This is documentSnapshot at createEntity : ${documentSnapshot.data()}");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "success", message: "Data Created Successfully", data: documentSnapshot);
    } else {
      print("Not able to create it");
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "unsuccessful", message: "Failed to create data", data: null);
    }
  } catch (e) {
    print('Error creating entity record: $e');
    return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(status: "error", message: "Error creating entity record", data: null);
  }
}



