class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({required this.id, required this.title, required this.completed});

  Todo copyWith(bool completed) {
    return Todo(id: id, title: title, completed: completed);
  }
}
