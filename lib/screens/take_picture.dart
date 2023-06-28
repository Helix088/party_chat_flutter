// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// Future<void> main() async {
//   // Ensure that plugin services are initialized so that `availableCameras()`
//   // can be called before `runApp()`
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtain a list of the available cameras on the device.
//   final cameras = await availableCameras();

//   // Get a specific camera from the list of available cameras.
//   final firstCamera = cameras.first;

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: TakePictureScreen(
//         // Pass the appropriate camera to the TakePictureScreen widget.
//         camera: firstCamera,
//       ),
//     ),
//   );
// }

// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({
//     Key? key,
//     required this.camera,
//   }) : super(key: key);

//   final CameraDescription camera;

//   static const String id = 'take_picture_screen';

//   @override
//   _TakePictureScreenState createState() => _TakePictureScreenState();
// }

// class _TakePictureScreenState extends State<TakePictureScreen> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;

//   Future<void> _takePicture() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _imageFile = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text('Take a picture'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: _imageFile == null
//           ? Center(
//               child: Text(
//                 'No image taken',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             )
//           : Image.file(File(_imageFile!.path)),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueGrey,
//         onPressed: _takePicture,
//         child: const Icon(
//           Icons.camera_alt,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// // // A screen that allows users to take a picture using a given camera.
// // class TakePictureScreen extends StatefulWidget {
// //   const TakePictureScreen({
// //     super.key,
// //     required this.camera,
// //   });

// //   final CameraDescription camera;

// //   static const String id = 'take_picture_screen';
// //   @override
// //   TakePictureScreenState createState() => TakePictureScreenState();
// // }

// // class TakePictureScreenState extends State<TakePictureScreen> {
// //   late CameraController _controller;
// //   late Future<void> _initializeControllerFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // To display the current output from the Camera,
// //     // create a CameraController.
// //     _controller = CameraController(
// //       // Get a specific camera from the list of available cameras.
// //       widget.camera,
// //       // Define the resolution to use.
// //       ResolutionPreset.medium,
// //     );

// //     // Next, initialize the controller. This returns a Future.
// //     _initializeControllerFuture = _controller.initialize();
// //   }

// //   @override
// //   void dispose() {
// //     // Dispose of the controller when the widget is disposed.
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //         title: const Text('Take a picture'),
// //         backgroundColor: Colors.blueGrey,
// //       ),
// //       // You must wait until the controller is initialized before displaying the
// //       // camera preview. Use a FutureBuilder to display a loading spinner until the
// //       // controller has finished initializing.
// //       body: FutureBuilder<void>(
// //         future: _initializeControllerFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             // If the Future is complete, display the preview.
// //             return CameraPreview(_controller);
// //           } else {
// //             // Otherwise, display a loading indicator.
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.blueGrey,
// //         // Provide an onPressed callback.
// //         onPressed: () async {
// //           // Take the Picture in a try / catch block. If anything goes wrong,
// //           // catch the error.
// //           try {
// //             // Ensure that the camera is initialized.
// //             await _initializeControllerFuture;

// //             // Attempt to take a picture and get the file `image`
// //             // where it was saved.
// //             final image = await _controller.takePicture();

// //             if (!mounted) return;

// //             // If the picture was taken, display it on a new screen.
// //             await Navigator.of(context).push(
// //               MaterialPageRoute(
// //                 builder: (context) => DisplayPictureScreen(
// //                   // Pass the automatically generated path to
// //                   // the DisplayPictureScreen widget.
// //                   imagePath: image.path,
// //                 ),
// //               ),
// //             );
// //           } catch (e) {
// //             // If an error occurs, log the error to the console.
// //             print(e);
// //           }
// //         },
// //         child: const Icon(
// //           Icons.camera_alt,
// //           color: Colors.white,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // A widget that displays the picture taken by the user.
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Display the Picture')),
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Image.file(File(imagePath)),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: ImagePickerScreen(),
  ));
}

class ImagePickerScreen extends StatefulWidget {
  static const String id = 'image_picker_screen';

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}
