import 'dart:convert';
import 'dart:io';

import 'package:admin_gm/bloc/other/other_bloc.dart';
import 'package:admin_gm/bloc/other/other_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddOtherScreen extends StatefulWidget {
  const AddOtherScreen({super.key});

  @override
  State<AddOtherScreen> createState() => _AddOtherScreenState();
}

class _AddOtherScreenState extends State<AddOtherScreen> {
  File? _image;
  List<String> _galleryUrls = [];
  String _imageUrl = '';
  String _name = '';
  String _city = '';
  String _description = '';
  String _category = '';
  String _note = '';
  String _location = '';

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporaty = File(image.path);

      setState(() {
        this._image = imageTemporaty;
      });
      final imageUrl = await _uploadImageToImgbb(imageTemporaty);
      setState(() {
        _imageUrl = imageUrl;
      });
      print(_galleryUrls);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future getGallery() async {
    List<XFile> _gallery = [];
    try {
      final List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages == null) return;

      setState(() {
        _gallery = pickedImages;
      });

      List<String> uploadedImageUrls = await _uploadGalleryToImgbb(_gallery);
      setState(() {
        _galleryUrls = uploadedImageUrls;
      });
      print(_galleryUrls);
    } on PlatformException catch (e) {
      print('Failed to pick gallery image: $e');
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

  Future<List<String>> _uploadGalleryToImgbb(List<XFile> images) async {
    final apiKey = 'd5f78bcd575593519265810c3fd2b4b8';
    final url = Uri.parse('https://api.imgbb.com/1/upload');

    List<String> imageUrls = [];

    for (var image in images) {
      var request = http.MultipartRequest('POST', url)
        ..fields['key'] = apiKey
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);
        final imageUrl = decoded['data']['url'];
        imageUrls.add(imageUrl);
      } else {
        throw Exception('Failed to upload image');
      }
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    void _postNews(context) {
      BlocProvider.of<OtherBloc>(context).add(OtherCreateEvent(
          arg['otherId'],
          arg['otherCity'],
          _city,
          _description,
          _location,
          _name,
          _note,
          _imageUrl,
          _galleryUrls));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(arg['label']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
            _galleryUrls.length == 0
                ? TextButton(
                    onPressed: () {
                      getGallery();
                    },
                    child: const Text('Добавить галерию'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: _galleryUrls.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Image.network(
                            _galleryUrls[index],
                            width: MediaQuery.of(context).size.width / 3,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
            TextField(
              maxLines: null,
              onChanged: (value) {
                _name = value;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Название'),
            ),
            TextField(
              maxLines: null,
              onChanged: (value) {
                _description = value;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Город и район'),
            ),
            TextFormField(
              onChanged: (value) {
                _city = value;
              },
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Город'),
            ),
            TextField(
              maxLines: null,
              onChanged: (value) {
                _note = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Описание'),
            ),
            TextField(
              maxLines: null,
              onChanged: (value) {
                _location = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Ссылка на объект из Гугл карты'),
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
    );
  }
}
