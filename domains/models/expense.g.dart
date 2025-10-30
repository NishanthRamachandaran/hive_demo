// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String? ?? 'General',
      type:
          $enumDecodeNullable(_$ExpenseTypeEnumMap, json['type']) ??
          ExpenseType.expense,
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.expense: 'expense',
  ExpenseType.income: 'income',
};
