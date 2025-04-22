class Cancellation {
  int? id;
  String? reason;
  Null createdAt;
  Null updatedAt;

  Cancellation({this.id, this.reason, this.createdAt, this.updatedAt});

  Cancellation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
