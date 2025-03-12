part of 'search_garage_bloc.dart';

@immutable
sealed class SearchGarageEvent {}

class InitialEvent extends SearchGarageEvent{}

class NearestGarageSearchEvent extends SearchGarageEvent{}

class CallToGarageEvent extends SearchGarageEvent{}


// part of 'search_garage_bloc.dart';

// @immutable
// sealed class SearchGarageEvent {}

// class InitialEvent extends SearchGarageEvent {}

// class NearestGarageSearchEvent extends SearchGarageEvent {}

// class CallToGarageEvent extends SearchGarageEvent {}
