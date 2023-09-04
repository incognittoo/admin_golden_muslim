import 'package:admin_gm/bloc/news/news_bloc.dart';
import 'package:admin_gm/bloc/news/news_event.dart';
import 'package:admin_gm/bloc/news/news_state.dart';
import 'package:admin_gm/data/models/news_model.dart';
import 'package:admin_gm/data/repositories/news_repo.dart';
import 'package:admin_gm/ui/widgets/news/news_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      minimum: EdgeInsets.all(8.0),
      child: ContentNews(),
    );
  }
}

class ContentNews extends StatefulWidget {
  const ContentNews({super.key});

  @override
  State<ContentNews> createState() => _ContentNewsState();
}

class _ContentNewsState extends State<ContentNews> {
  @override
  void initState() {
    super.initState();
    final NewsBloc newsBloc = context.read<NewsBloc>();
    newsBloc.add(NewsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if (state is NewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NewsLoadedState) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.loadedNews.length,
              itemBuilder: (context, index) {
                return NewsCart(
                  news: state.loadedNews[index],
                );
              });
        }
        if (state is NewsErrorState) {
          return const Center(
            child: Text(
              'Ошибка при загрузки данных',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_news',
              arguments: 'Добавить новость');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
