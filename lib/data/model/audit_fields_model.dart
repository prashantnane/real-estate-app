import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Auditable {
  AuditFields? auditfields;
}

// Define the AuditFields class
class AuditFields {
  final DocumentReference createdBy;
  final Timestamp createdDateTime;
  final DocumentReference modifiedBy;
  final Timestamp modifiedDateTime;

  AuditFields({
    required this.createdBy,
    required this.createdDateTime,
    required this.modifiedBy,
    required this.modifiedDateTime,
  });

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDateTime": createdDateTime,
    "modifiedBy": modifiedBy,
    "modifiedDateTime": modifiedDateTime,
  };

  factory AuditFields.fromJson(Map<String, dynamic> json) => AuditFields(
    createdBy: json["createdBy"],
    createdDateTime: json["createdDateTime"],
    modifiedBy: json["modifiedBy"],
    modifiedDateTime: json["modifiedDateTime"],
  );
}