import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class AlzheimerDiseseService extends StatefulWidget {
  AlzheimerDiseseService({Key? key}) : super(key: key);

  @override
  _AlzheimerDiseseServiceState createState() => _AlzheimerDiseseServiceState();
}

class _AlzheimerDiseseServiceState extends State<AlzheimerDiseseService> {
  late Interpreter _interpreter;
  List<String> _labels = [];
  File? _imagePath;
  String _classification = '';
  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      var interpreterOptions = InterpreterOptions();
      _interpreter = await Interpreter.fromAsset(
        'assets/models/Alzahimer model .tflite',
        options: interpreterOptions,
      );

      var labelsData =
          await rootBundle.loadString('assets/models/Alzahimer labels.txt');
      _labels = labelsData.split('\n').map((label) => label.trim()).toList();
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  void classifyImage(File imageFile) async {
    try {
      if (_interpreter == null) {
        print('Interpreter not initialized.');
        return;
      }

      // Read image bytes
      var imageBytes = imageFile.readAsBytesSync();
      var inputShape = _interpreter.getInputTensor(0).shape;
      var inputType = _interpreter.getInputTensor(0).type;

      // Convert image to input tensor shape [1, 224, 224, 3]
      var inputTensor = List.generate(
        inputShape[1],
        (i) => List.generate(
          inputShape[2],
          (j) => List.generate(inputShape[3], (k) => 0.0),
        ),
      );

      // Assuming the image is 224x224
      int index = 0;
      for (int x = 0; x < 224; x++) {
        for (int y = 0; y < 224; y++) {
          inputTensor[x][y][0] = (imageBytes[index] / 255.0); // Red
          inputTensor[x][y][1] = (imageBytes[index + 1] / 255.0); // Green
          inputTensor[x][y][2] = (imageBytes[index + 2] / 255.0); // Blue
          index += 3;
        }
      }

      // Convert the 3D input tensor to a 4D tensor
      var input = [inputTensor];

      // Define output shape and buffer
      var output =
          List.filled(_labels.length, 0.0).reshape([1, _labels.length] as int);

      // Run inference
      _interpreter.run(input, output);

      var maxIndex = output[0]
          .indexOf(output[0].reduce((curr, next) => curr > next ? curr : next));
      var confidence = output[0][maxIndex];

      setState(() {
        _classification = _labels[maxIndex];
        _confidence = confidence;
      });
    } catch (e) {
      print('Error classifying image: $e');
    }
  }

  void pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
        _classification = '';
        _confidence = 0.0;
      });
      classifyImage(_imagePath!);
    }
  }

  void takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
        _classification = '';
        _confidence = 0.0;
      });
      classifyImage(_imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alzheimer\'s Disease',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 12),
              Card(
                elevation: 20,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _imagePath == null
                              ? Icon(
                                  Icons.image_outlined,
                                  size: 170,
                                )
                              : Image.file(_imagePath!, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '$_classification',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '$_classification\n Accuracy: ${(_confidence * 100).toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: takePhoto,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: const Text(
                  'Take a Photo',
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  pickImageGallery();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: const Text(
                  'Upload from Gallery',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ListUtils<T> on List<T> {
  List<List<T>> reshape(int cols) {
    var list = this;
    int rows = (list.length / cols).ceil();
    return List.generate(
        rows,
        (i) => list.sublist(i * cols,
            i * cols + cols > list.length ? list.length : i * cols + cols));
  }
}
