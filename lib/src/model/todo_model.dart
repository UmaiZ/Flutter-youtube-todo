class TodoModel {
  String? sId;
  String? todoTitle;
  String? todoDescription;

  TodoModel({this.sId, this.todoTitle, this.todoDescription});

  TodoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    todoTitle = json['todo_title'];
    todoDescription = json['todo_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['todo_title'] = todoTitle;
    data['todo_description'] = todoDescription;
    return data;
  }
}
