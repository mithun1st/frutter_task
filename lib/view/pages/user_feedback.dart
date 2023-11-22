import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutter/bloc/feedback/feedback_bloc.dart';
import 'package:frutter/controller/service.dart';
import 'package:frutter/view/widget/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class UserFeedback extends StatefulWidget {
  static const String pageName = "/feedBack";

  const UserFeedback({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserFeedbackState();
  }
}

class _UserFeedbackState extends State<UserFeedback> {
  final FeedbackBloc _feedbackBloc = FeedbackBloc();

  File? _fileImage;

  bool _isRecOn = false;
  String? _audioFilePath;

  final AudioRecorder _record = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  void _getImage(ImageSource src) async {
    XFile? xf = await ImagePicker().pickImage(source: src);
    if (xf == null) {
      return;
    }
    _fileImage = File(xf.path);
    _feedbackBloc.add(FeedbackImageEvent());
  }

  Future<void> _startRecord() async {
    // Check and request permission if needed
    if (await _record.hasPermission()) {
      // Start recording and save to cache
      final String path = (await getApplicationDocumentsDirectory()).path;
      await _record.start(const RecordConfig(), path: '$path/rec_file1.wav');
    }
  }

  Future<String?> _stopRecord() async {
    // Stop recording
    final path = await _record.stop();
    return path;
  }

  Future<void> _playAudio(String path) async {
    await _player.play(UrlSource(path));
  }

  @override
  void dispose() {
    super.dispose();

    _record.dispose();
    _player.dispose();
    _feedbackBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar("Feedback"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //############################# Feedback msg section
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: _feedBackTextField(
                TextEditingController(),
              ),
            ),
            const SizedBox(height: 20),
            //#############################  Image upload section
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // image preview
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: BlocBuilder(
                        bloc: _feedbackBloc,
                        buildWhen: (previous, current) => current is FeedbackImageState,
                        builder: (context, state) {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.center,
                            color: Colors.grey,
                            child: _fileImage == null
                                ? Text(
                                    "No Image",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  )
                                : Image.file(
                                    _fileImage!,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                          );
                        },
                      ),
                    ),
                    // image submit
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Upload\nImage"),
                          IconButton(
                            onPressed: () {
                              _getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera),
                          ),
                          IconButton(
                            onPressed: () {
                              _getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //############################# Record section
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: BlocBuilder(
                bloc: _feedbackBloc,
                buildWhen: (previous, current) => current is FeedbackRecordState,
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(_isRecOn ? "Recording..." : "Tap Start To Voice Record"),
                            ElevatedButton.icon(
                              onPressed: () async {
                                if (!_isRecOn) {
                                  _startRecord();
                                } else {
                                  _audioFilePath = await _stopRecord();
                                }
                                _isRecOn = !_isRecOn;
                                _feedbackBloc.add(FeedbackRecordEvent());
                              },
                              icon: _isRecOn ? const Icon(Icons.stop) : const Icon(Icons.mic),
                              label: Text(_isRecOn ? "Stop" : "Start"),
                            ),
                          ],
                        ),
                        // rec file show if exist
                        Visibility(
                          visible: _audioFilePath != null && !_isRecOn,
                          child: Card(
                            elevation: 12,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(" ${_audioFilePath.toString().split("/")[_audioFilePath.toString().split("/").length - 1]}"),
                                IconButton(
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  onPressed: () async => await _playAudio(_audioFilePath!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ///############################# Submit Feedback section
            Flexible(
              flex: 1,
              child: ElevatedButton(
                  onPressed: () async {
                    AllServices.showSuccessMsg(context, "Thanks for Your Feedback");
                  },
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }

  //############################# WIDGET FUNCTION
  Widget _feedBackTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "write your feedback...",
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
