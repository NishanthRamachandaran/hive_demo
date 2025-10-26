import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task.freezed.dart';

@freezed
@HiveType(typeId: 0)
class Task with _$Task {
  const factory Task({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required bool completed,
    @HiveField(3) required DateTime createdAt,
  }) = _Task;

  factory Task.create(String title) {
    return Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      completed: false,
      createdAt: DateTime.now(),
    );
  }
}