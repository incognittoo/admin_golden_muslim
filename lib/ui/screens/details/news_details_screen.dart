import 'package:admin_gm/bloc/news/news_bloc.dart';
import 'package:admin_gm/bloc/news/news_event.dart';
import 'package:admin_gm/data/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)!.settings.arguments as News;
    void _deleteNews(context) {
      BlocProvider.of<NewsBloc>(context).add(NewsDeleteEvent(news.id));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(children: [
          Image(
            image: NetworkImage(news.img),
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                _deleteNews(context);
                Navigator.of(context).pop();
              },
              child: const Text('Удалить новость',
                  style: TextStyle(color: Colors.red))),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(news.t, style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(news.cat),
              ),
              SizedBox(
                child: Text(news.formattedTime()),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(news.d1),
          )
        ])),
      ),
    );
  }
}
