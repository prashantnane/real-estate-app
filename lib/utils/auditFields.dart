import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/model/audit_fields_model.dart';
import 'app_constant.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<DocumentReference?> getUserDocumentReferenceNew(String collectionName,String userId) async {
  try {
    DocumentReference documentReference = _firestore.collection(collectionName).doc(userId);
    print('documentReference at getUserDocumentReferenceNew: $documentReference');
    return documentReference;
  } catch (e) {
    print('Error getting getUserDocumentReferenceNew: $e');
    return null;
  }
}


Future<DocumentReference?> getDocumentReferenceNew(String collectionName,String userId) async {
  try {
    DocumentReference documentReference = _firestore.collection(collectionName).doc(userId);
    print('documentReference: $documentReference');
    return documentReference;
  } catch (e) {
    print('Error getting getDocumentReferenceNew: $e');
    return null;
  }
}

Future<void> addAuditFields(String collection, String docId) async {
  DocumentReference<Object?>? modifiedBy = await getUserDocumentReferenceNew(FirebaseCollection.users,FirebaseAuth.instance.currentUser?.uid??"invalid");
  DocumentReference<Object?>? createdBy =await getUserDocumentReferenceNew(FirebaseCollection.users,FirebaseAuth.instance.currentUser?.uid??"invalid");
  AuditFields data = AuditFields(createdBy: createdBy!, createdDateTime: Timestamp.now(), modifiedBy: modifiedBy!, modifiedDateTime:  Timestamp.now());
  Map<String,dynamic> datainJson = data.toJson();
  print("this is datainJson : $datainJson");
  print("addAuditFields run");
  // StorageUtils.writeDataInStorage(Preference.user_AuditFields, datainJson);
  await _firestore.collection(collection).doc(docId).update({'auditFields': datainJson}).onError((e, _) => print("Error in updating document: $e"));
}