import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class NewsLoadEvent extends NewsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsCreateEvent extends NewsEvent {
  final String img;
  final String t;
  final String cat;
  final String d1;
  final DateTime times;

  NewsCreateEvent(this.img, this.t, this.cat, this.d1, this.times);

  @override
  // TODO: implement props
  List<Object?> get props => [img, t, cat, d1, times];
}

class NewsDeleteEvent extends NewsEvent {
  final String id;

  NewsDeleteEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
