class ErrorModel {
  final String name;
  final String message;
  final int? status;
  final String? type;

  const ErrorModel({
    required this.name,
    required this.message,
    required this.status,
    required this.type,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      name: json['name'] as String,
      message: json['message'] as String,
      status: json['status'] as int?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'status': status,
      'type': type,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ErrorModel &&
        other.name == name &&
        other.message == message &&
        other.status == status &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(name, message, status, type);

  @override
  String toString() {
    return 'ErrorModel(name: $name, message: $message, status: $status, type: $type)';
  }
}
