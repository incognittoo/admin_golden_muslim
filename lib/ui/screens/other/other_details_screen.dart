import 'package:admin_gm/bloc/other/other_bloc.dart';
import 'package:admin_gm/bloc/other/other_event.dart';
import 'package:admin_gm/bloc/other/other_state.dart';
import 'package:admin_gm/data/models/other_list_model.dart';
import 'package:admin_gm/ui/widgets/other/other_object_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherDetailScreen extends StatefulWidget {
  const OtherDetailScreen({super.key});

  @override
  State<OtherDetailScreen> createState() => _OtherDetailScreenState();
}

class _OtherDetailScreenState extends State<OtherDetailScreen> {
  String _otherId = '';
  String _otherCity = '';
  OtherList? _otherList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    _otherList = arguments!['otherList'];
    setState(() {
      _otherId = arguments['otherList'].id;
      _otherCity = arguments['selectedCity'].id;
    });
    final OtherBloc otherBloc = context.read<OtherBloc>();
    otherBloc.add(OtherLoadEvent(otherCity: _otherCity, otherId: _otherId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Text(
          _otherList?.name ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<OtherBloc, OtherState>(
            builder: (context, state) {
              if (state is OtherLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OtherLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.loadedOther.length,
                  itemBuilder: (context, index) {
                    return OtherObjectCart(
                        other: state.loadedOther[index],
                        arg: {
                          'otherId': _otherId,
                          'otherCity': _otherCity,
                        });
                  },
                );
              }
              if (state is OtherErrorState) {
                return const Center(
                  child: Text('Ошибка при загрузки данных'),
                );
              }
              return Container();
            },
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_other', arguments: {
            'otherId': _otherId,
            'otherCity': _otherCity,
            'label': 'Добавить объект'
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
