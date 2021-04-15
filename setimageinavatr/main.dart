import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _image;
  final picker = ImagePicker();

  Future openCamera() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    //  final fileName = path.basename(_image.path);
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Picker Example'),
        ),
        body: Center(
          child: _image == null
              ? Text('No image selected.')
              : InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 39.0,
                    child: CircleAvatar(
                      radius: 38.0,
                      backgroundImage: new FileImage(File(_image.path)),
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              // _imgFromGallery
              () {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                  // backgroundColor: Color(0xffFA6F48),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  title: Container(
                    decoration: BoxDecoration(
                        // color: Color(0xffFA6F48),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: new ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // **********GALLERY ********************
                        new ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffFA6F48), // background
                            onPrimary: Color(0xff1D252F), //FOREGROUND
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () => {
                            openCamera(),
                            Navigator.of(ctx).pop(),
                          },
                          child: new Icon(
                            Icons.camera,
                            size: 30,
                          ),
                        ),

                        // **************CAMERA*****************
                        new ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffFA6F48), // background
                            onPrimary: Color(0xff1D252F), // foreground

                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () => {
                            _imgFromGallery(),
                            Navigator.of(ctx).pop(),
                          },
                          child: new Icon(
                            Icons.photo,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
          tooltip: 'Pick Image from gallery ',
          child: Icon(Icons.add_a_photo),
        ));
  }
}
