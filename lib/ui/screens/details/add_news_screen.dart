import 'dart:convert';
import 'dart:io';

import 'package:admin_gm/bloc/news/news_bloc.dart';
import 'package:admin_gm/bloc/news/news_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  File? _image;
  String _imageUrl = '';
  String _title = '';
  String _category = '';
  String _description = '';
  final DateTime _times = DateTime.now();

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporaty = File(image.path);

      setState(() {
        this._image = imageTemporaty;
      });
      final imageUrl = await _uploadImageToImgbb(imageTemporaty);
      print(imageUrl);
      setState(() {
        _imageUrl = imageUrl;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future _uploadImageToImgbb(File image) async {
    final apiKey = 'd5f78bcd575593519265810c3fd2b4b8';
    final url = Uri.parse('https://api.imgbb.com/1/upload');

    var request = http.MultipartRequest('POST', url)
      ..fields['key'] = apiKey
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);
      final imageUrl = decoded['data']['url'];
      return imageUrl;
    } else {
      throw Exception('Failed to upload image');
    }
  }

  void _postNews(context) {
    BlocProvider.of<NewsBloc>(context).add(NewsCreateEvent(
      _imageUrl,
      _title,
      _category,
      _description,
      _times,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arg.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image == null
                  ? TextButton(
                      onPressed: () {
                        getImage();
                      },
                      child: const Text('Добавить изоображение'))
                  : Image.file(
                      _image!,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
              TextField(
                maxLines: null,
                onChanged: (value) {
                  _title = value;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Заголовок'),
              ),
              TextFormField(
                onChanged: (value) {
                  _category = value;
                },
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Категория'),
              ),
              TextField(
                maxLines: null,
                onChanged: (value) {
                  _description = value;
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Описание'),
              ),
              ElevatedButton(
                  onPressed: _imageUrl != ''
                      ? () {
                          _postNews(context);
                          Navigator.of(context).pop();
                        }
                      : () {},
                  child: const Text('Загрузить'))
            ],
          ),
        ),
      ),
    );
  }
}
