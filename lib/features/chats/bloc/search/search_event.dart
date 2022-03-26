part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserEvent extends SearchEvent {
  final String searchTerm;

  const SearchUserEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class SearchEmitIdleEvent extends SearchEvent {
  const SearchEmitIdleEvent();

  @override
  List<Object> get props => [];
}
