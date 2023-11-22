import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/bloc/feedback/feedback_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageView extends StatefulWidget {
  final Function fnc;
  final String label;
  final String defaultUrl;
  const ImageView({super.key, required this.fnc, required this.label, required this.defaultUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  File? imageFile;

  FeedbackBloc imageBloc = FeedbackBloc();

  void getImage(ImageSource src) async {
    XFile? xf = await ImagePicker().pickImage(source: src);
    if (xf == null) {
      return;
    }

    imageFile = File(xf.path);
    widget.fnc(xf.path);
    imageBloc.add(FeedbackImageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.titleMedium),
          AspectRatio(
            aspectRatio: 1 / .5,
            child: BlocBuilder(
              bloc: imageBloc,
              buildWhen: (previous, current) => current is FeedbackImageState,
              builder: (context, state) {
                return imageFile == null
                    ? Image.network(
                        widget.defaultUrl,
                        //loadingBuilder: (context, child, loadingProgress) => const Text('Loading...'),
                      )
                    : Image.file(
                        imageFile!,
                        // width: double.infinity,
                        // fit: BoxFit.contain,
                      );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: const Text('Upload From\nCamera'),
              ),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Text('Upload From\nGallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
