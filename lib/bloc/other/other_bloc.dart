import 'package:admin_gm/bloc/other/other_event.dart';
import 'package:admin_gm/bloc/other/other_state.dart';
import 'package:admin_gm/data/models/other_model.dart';
import 'package:admin_gm/data/repositories/other_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  final OtherRepository otherRepository;

  OtherBloc(this.otherRepository) : super(OtherEmptyState()) {
    on<OtherLoadEvent>((event, emit) async {
      emit(OtherLoadingState());
      try {
        final List<Other> loadedOther = await otherRepository.getOther(
          otherId: event.otherId,
          otherCity: event.otherCity,
        );
        emit(OtherLoadedState(loadedOther: loadedOther));
      } catch (e) {
        emit(OtherErrorState(e.toString()));
      }
    });

    on<OtherCreateEvent>((event, emit) async {
      emit(OtherAddingState());
      try {
        await otherRepository.postOther(
            otherId: event.otherId,
            otherCity: event.otherCity,
            city: event.city,
            description: event.description,
            location: event.location,
            name: event.name,
            note: event.note,
            photo: event.photo,
            gallery: event.gallery);
      } catch (e) {
        emit(OtherErrorState(e.toString()));
      }
    });

    on<OtherDeleteEvent>((event, emit) async {
      emit(OtherDeletingState());
      try {
        await otherRepository.deleteOther(
            otherId: event.otherId,
            otherCity: event.otherCity,
            objectId: event.objectId);
      } catch (e) {
        emit(OtherErrorState(e.toString()));
      }
    });
  }
}
