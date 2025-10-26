import 'package:hive/hive.dart';
import 'package:riverpod/riverpod.dart';
import '../models/task.dart';

// Hive Box Provider
final taskBoxProvider = Provider<Box<Task>>((ref) {
  return Hive.box<Task>('tasks');
});

// Tasks Provider
final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final box = ref.watch(taskBoxProvider);
  return TaskNotifier(box);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final Box<Task> _box;
  
  TaskNotifier(this._box) : super(_box.values.toList());

  void addTask(String title) {
    final task = Task.create(title);
    _box.add(task);
    state = _box.values.toList();
  }

  void toggleTask(String id) {
    final index = _box.values.toList().indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _box.getAt(index);
      final updatedTask = task!.copyWith(completed: !task.completed);
      _box.putAt(index, updatedTask);
      state = _box.values.toList();
    }
  }

  void deleteTask(String id) {
    final index = _box.values.toList().indexWhere((task) => task.id == id);
    if (index != -1) {
      _box.deleteAt(index);
      state = _box.values.toList();
    }
  }

  void clearCompleted() {
    final completedTasks = _box.values.where((task) => task.completed).toList();
    for (final task in completedTasks) {
      final index = _box.values.toList().indexWhere((t) => t.id == task.id);
      if (index != -1) _box.deleteAt(index);
    }
    state = _box.values.toList();
  }
}