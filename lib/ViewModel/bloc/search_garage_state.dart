part of 'search_garage_bloc.dart';

@immutable
sealed class SearchGarageState {}

final class SearchGarageInitial extends SearchGarageState {}

abstract class SearchActionState extends SearchGarageState{}

class InitialState extends SearchGarageState{}

class SearchResultState extends SearchGarageState{
  final List<Map<String, dynamic>> searchResult;
  SearchResultState(this.searchResult);
}

class SearchInProgressState extends SearchGarageState{}

class SearchErrorState extends SearchGarageState{
  final String errorMessage;
  SearchErrorState(this.errorMessage);
}




// part of 'search_garage_bloc.dart';

// @immutable
// sealed class SearchGarageState {}

// class InitialState extends SearchGarageState {}

// class SearchResultState extends SearchGarageState {}

// class CallToGarageState extends SearchGarageState {}
