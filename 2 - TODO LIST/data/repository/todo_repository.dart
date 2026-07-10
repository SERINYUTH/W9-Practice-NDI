import '../../models/todo.dart';

class TodoRepository {
  static final global = TodoRepository();   // unique instance

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
 
    return Future.delayed(Duration(seconds: 1), () {
      return fakeTodos;

      //  TODO
      // Ensure the message is displayed on the UI if error occured
      //throw RepositoryException("No wifi !");

    });
  }

  Future<void> updateCompleted(String todoId, bool completed) async {
    
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //
    int index = fakeTodos.indexWhere((e) => e.id == todoId);
    fakeTodos[index] = fakeTodos[index].copyWith(completed);

    return Future.delayed(Duration(microseconds: 1), () => true);
  }
}
