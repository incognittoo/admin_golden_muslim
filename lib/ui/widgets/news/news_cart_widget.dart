import 'package:admin_gm/data/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsCart extends StatelessWidget {
  final News news;
  const NewsCart({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/news_details', arguments: news);
      },
      child: SizedBox(
        height: 210,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(news.img),
                fit: BoxFit.cover,
              )),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                news.t,
                maxLines: 2,
              ),
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
          ],
        ),
      ),
    );
  }
}
