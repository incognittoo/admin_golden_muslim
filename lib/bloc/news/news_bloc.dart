import 'package:admin_gm/bloc/news/news_event.dart';
import 'package:admin_gm/bloc/news/news_state.dart';
import 'package:admin_gm/data/models/news_model.dart';
import 'package:admin_gm/data/repositories/news_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsEmptyState()) {
    on<NewsLoadEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final List<News> loadedNewsList = await newsRepository.getNews();
        emit(NewsLoadedState(loadedNews: loadedNewsList));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });

    on<NewsCreateEvent>((event, emit) async {
      emit(NewsAddingState());
      try {
        await newsRepository.postNews(
          img: event.img,
          t: event.t,
          cat: event.cat,
          d1: event.d1,
          times: event.times,
        );
        emit(NewsAddedState());
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });

    on<NewsDeleteEvent>(
      (event, emit) async {
        emit(NewsDeletingState());
        try {
          await newsRepository.deleteNews(id: event.id);
        } catch (e) {
          emit(NewsErrorState(e.toString()));
        }
      },
    );
  }
}
