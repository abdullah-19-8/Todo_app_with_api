class TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    return data;
  }
}
