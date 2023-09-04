import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {}

class NewsEmptyState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  List<dynamic> loadedNews;
  NewsLoadedState({required this.loadedNews});

  @override
  // TODO: implement props
  List<Object?> get props => [loadedNews];
}

class NewsErrorState extends NewsState {
  final String error;
  NewsErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

// CREATE NEWS STATE

class NewsAddingState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsAddedState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsDeletingState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsDeleteState extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
