part of 'itemsbloc_bloc.dart';

@immutable
sealed class ItemsblocState {}

final class ItemsblocInitial extends ItemsblocState {}
final class ItemsblocLoading extends ItemsblocState {}
final class ItemsblocSucces extends ItemsblocState {}
final class ItemsblocEmpty extends ItemsblocState {}
final class ItemsblocError extends ItemsblocState {}
