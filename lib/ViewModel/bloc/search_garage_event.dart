part of 'search_garage_bloc.dart';

@immutable
sealed class SearchGarageEvent {}

class InitialEvent extends SearchGarageEvent{}

class NearestGarageSearchEvent extends SearchGarageEvent{
  final double radius;
  NearestGarageSearchEvent({required this.radius});
}

class CallToGarageEvent extends SearchGarageEvent{
  final String phoneNumber;
  CallToGarageEvent(this.phoneNumber);
}


// part of 'search_garage_bloc.dart';

// @immutable
// sealed class SearchGarageEvent {}

// class InitialEvent extends SearchGarageEvent {}

// class NearestGarageSearchEvent extends SearchGarageEvent {}

// class CallToGarageEvent extends SearchGarageEvent {}
