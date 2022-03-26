import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:howdy/features/auth/models/models.dart';
import 'package:howdy/features/chats/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserSearchServices _searchServices = UserSearchServices();
  SearchBloc() : super(SearchIdle()) {
    on<SearchUserEvent>(_onSearchUserEvent);
    on<SearchEmitIdleEvent>(_onSearchEmitIdleEvent);
  }

  Future<FutureOr<void>> _onSearchUserEvent(
      SearchUserEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    var users = await _searchServices.searchUsers(event.searchTerm);
    emit(SearchLoaded(users));
  }

  FutureOr<void> _onSearchEmitIdleEvent(
      SearchEmitIdleEvent event, Emitter<SearchState> emit) {
    emit(SearchIdle());
  }
}
