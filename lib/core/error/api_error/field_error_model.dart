class FieldErrorModel {
  final String field;
  final String message;

  const FieldErrorModel({
    required this.field,
    required this.message,
  });

  factory FieldErrorModel.fromJson(Map<String, dynamic> json) {
    return FieldErrorModel(
      field: json['field'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FieldErrorModel && other.field == field && other.message == message;
  }

  @override
  int get hashCode => Object.hash(field, message);

  @override
  String toString() {
    return 'FieldErrorModel(field: $field, message: $message)';
  }
}
