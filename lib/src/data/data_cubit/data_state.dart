part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}
class DataLoading extends DataState {}
class DataSuccess extends DataState {}
class DataError extends DataState {}
class DataEmpty extends DataState {}
