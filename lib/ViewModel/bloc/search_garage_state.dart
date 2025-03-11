part of 'search_garage_bloc.dart';

@immutable
sealed class SearchGarageState {}

final class SearchGarageInitial extends SearchGarageState {}

abstract class SearchActionState extends SearchGarageState{}

class InitialState extends SearchActionState{}

class SearchResultState extends SearchActionState{}

class CallToGarageState extends SearchActionState{}
