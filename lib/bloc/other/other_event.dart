import 'package:equatable/equatable.dart';

abstract class OtherEvent extends Equatable {}

class OtherLoadEvent extends OtherEvent {
  final String otherId;
  final String otherCity;

  OtherLoadEvent({required this.otherCity, required this.otherId});

  @override
  // TODO: implement props
  List<Object?> get props => [otherId, otherCity];
}

class OtherCreateEvent extends OtherEvent {
  final String otherId;
  final String otherCity;
  final String city;
  final String description;
  final String location;
  final String name;
  final String note;
  final String photo;
  final List<String> gallery;

  OtherCreateEvent(this.otherId, this.otherCity, this.city, this.description,
      this.location, this.name, this.note, this.photo, this.gallery);

  @override
  // TODO: implement props
  List<Object?> get props => [name, photo];
}

class OtherDeleteEvent extends OtherEvent {
  final String otherId;
  final String otherCity;
  final String objectId;

  OtherDeleteEvent(this.otherId, this.otherCity, this.objectId);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
