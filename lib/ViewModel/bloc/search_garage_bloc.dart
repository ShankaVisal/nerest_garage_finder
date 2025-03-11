import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_garage_event.dart';
part 'search_garage_state.dart';

class SearchGarageBloc extends Bloc<SearchGarageEvent, SearchGarageState> {
  SearchGarageBloc() : super(SearchGarageInitial()) {
    on<InitialEvent>(initialEvent);
    on<SearchGarageEvent>(searchGarageEvent);
    on<CallToGarageEvent>(callToGarageEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<SearchGarageState> emit) {
    emit(
      InitialState()
    );
  }

  FutureOr<void> searchGarageEvent(
      SearchGarageEvent event, Emitter<SearchGarageState> emit) {
        emit(
          SearchResultState()
        );
      }

  FutureOr<void> callToGarageEvent(
      CallToGarageEvent event, Emitter<SearchGarageState> emit) {
    emit(
      CallToGarageState()
    );
  }
}
