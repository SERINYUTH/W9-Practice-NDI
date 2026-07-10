import 'dart:convert';

import '../../models/todo.dart';

class TodoDto {
  static const id = "id";
  static const title = "title";
  static const completed = "completed";

  static Todo fromJson(String id, Map<String, dynamic> json) {
    // Assert the map contains the keys  title and completed with the right data types

    // Return the right todo object by reading the json map
    return Todo(id: "fake", title: "fake", completed: false);
  }

  static Map<String, dynamic> toJson(Todo todo) {
    return {title: todo.title, completed: todo.completed};
  }
}

void main() {
  // JSON string simulating Firebase "todos" collection
  const jsonString = '''
  {
    "1": {
      "title": "Buy groceries",
      "completed": false
    },
    "2": {
      "title": "Finish Flutter homework",
      "completed": true
    },
    "3": {
      "title": "Call the dentist",
      "completed": false
    }
  }
  ''';

  // Decode JSON string into Map
  final Map<String, dynamic> data = jsonDecode(jsonString);

  // Convert each entry using fromJson
  final List<Todo> todos = data.entries.map((entry) {
    final id = entry.key;
    final json = entry.value as Map<String, dynamic>;

    return TodoDto.fromJson(id, json);
  }).toList();
}
