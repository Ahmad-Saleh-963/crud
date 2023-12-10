part of 'itemsbloc_bloc.dart';



@immutable
sealed class ItemsblocEvent {}


class ItemsGetEvent extends ItemsblocEvent{}
class ItemsDeleteEvent extends ItemsblocEvent{}
class ItemsRefrechUiEvent extends ItemsblocEvent{}

