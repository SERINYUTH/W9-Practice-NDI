import '../../models/todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/todo_dto.dart';
import 'repository_exception.dart';

class TodoRepository {
  static final global = TodoRepository(); // unique instance

  final List<Todo> fakeTodos = [
    Todo(id: '1', title: 'Buy groceries', completed: false),
    Todo(id: '2', title: 'Finish Flutter homework', completed: true),
    Todo(id: '3', title: 'Call the dentist', completed: false),
    Todo(id: '4', title: 'Read 20 pages of a book', completed: true),
    Todo(id: '5', title: 'Go for a 30-minute walk', completed: false),
  ];

  Future<List<Todo>> getTodos() async {
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //
    final url = Uri.parse(
      'https://y2t3-md-default-rtdb.asia-southeast1.firebasedatabase.app/todos.json',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw RepositoryException(
        'Failed to fetch todos (HTTP ${response.statusCode})',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return json.entries
        .map((e) => TodoDto.fromJson(e.key, e.value as Map<String, dynamic>))
        .toList();

    //  TODO
    // Ensure the message is displayed on the UI if error occured
    //throw RepositoryException("No wifi !");
  }

  Future<void> updateCompleted(String todoId, bool completed) async {
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //
    final url = Uri.parse(
      'https://y2t3-md-default-rtdb.asia-southeast1.firebasedatabase.app/todos/$todoId.json',
    );

    final response = await http.patch(
      url,
      body: jsonEncode({TodoDto.completed: completed}),
    );

    if (response.statusCode != 200) {
      throw RepositoryException(
        'Failed to update todo (HTTP ${response.statusCode})',
      );
    }

    // int index = fakeTodos.indexWhere((e) => e.id == todoId);
    // fakeTodos[index] = fakeTodos[index].copyWith(completed);

    return Future.delayed(Duration(microseconds: 1), () => true);
  }
}
