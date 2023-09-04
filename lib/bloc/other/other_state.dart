import 'package:equatable/equatable.dart';

abstract class OtherState extends Equatable {}

class OtherEmptyState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtherLoadingState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtherLoadedState extends OtherState {
  List<dynamic> loadedOther;
  OtherLoadedState({required this.loadedOther});
  @override
  // TODO: implement props
  List<Object?> get props => [loadedOther];
}

class OtherErrorState extends OtherState {
  final String error;
  OtherErrorState(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

/* Create objects other */

class OtherAddingState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtherAddedState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtherDeletingState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OtherDeletedState extends OtherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
