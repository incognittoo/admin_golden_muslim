import 'package:admin_gm/bloc/news/news_bloc.dart';
import 'package:admin_gm/bloc/other/other_bloc.dart';
import 'package:admin_gm/data/repositories/news_repo.dart';
import 'package:admin_gm/data/repositories/other_repo.dart';
import 'package:admin_gm/ui/navigation/navigation_app.dart';
import 'package:admin_gm/ui/screens/details/add_news_screen.dart';
import 'package:admin_gm/ui/screens/other/add_other_screen.dart';
import 'package:admin_gm/ui/screens/details/news_details_screen.dart';
import 'package:admin_gm/ui/screens/other/other_details_screen.dart';
import 'package:admin_gm/ui/screens/other/other_object_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final newsRepository = NewsRepository();
  final otherRepository = OtherRepository();
  final newsBloc = NewsBloc(newsRepository);
  final otherBloc = OtherBloc(otherRepository);
  runApp(AdminGM(newsBloc, otherBloc));
}

class AdminGM extends StatelessWidget {
  final NewsBloc newsBloc;
  final OtherBloc otherBloc;
  const AdminGM(this.newsBloc, this.otherBloc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => newsBloc),
        BlocProvider(create: (context) => otherBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const NavigationApp(),
          '/news_details': (context) => const NewsDetailsScreen(),
          '/add_news': (context) => const AddNewsScreen(),
          '/other_details': (context) => const OtherDetailScreen(),
          '/other_objects_details': (context) =>
              const OtherObjectDetailScreen(),
          '/add_other': (context) => const AddOtherScreen(),
        },
      ),
      // BlocProvider(
      // create: (context) => newsBloc,
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   initialRoute: '/',
      //   routes: {
      //     '/': (context) => const NavigationApp(),
      //     '/news_details': (context) => const NewsDetailsScreen(),
      //     '/add_news': (context) => const AddNewsScreen(),
      //     '/other_details': (context) => const OtherDetailScreen()
      //   },
      // ),
    );
  }
}
