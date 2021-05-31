import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'second.dart';

class firstScreen extends StatefulWidget {
  @override
  _firstScreenState createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  final _picker = ImagePicker();
  late File _imageFile;
  Future<String> uploadImageAndGetURL(img) async {
    final Reference itemPicRef = FirebaseStorage.instance.ref().child("images");
    String nameForPicture = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        itemPicRef.child(nameForPicture + ".jpg").putFile(img);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  var response;
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ElevatedButton(
            onPressed: () {
              Future<void> upload() async {
                final pickedImage =
                    await _picker.getImage(source: ImageSource.gallery);

                setState(() {
                  _imageFile = File(pickedImage!.path);
                });
                var imgUrl = await uploadImageAndGetURL(_imageFile);
                print(imgUrl);

                var uri = Uri.parse(
                    "https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement");
                String data = '''"imageURL":"${imgUrl}"''';
                response = await http.post(uri, body: jsonEncode(data));
                result = jsonDecode(response.body);
                print(result);
                var dat = result["neck"];
              }

              upload().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => secondPage(result)));
              });
            },
            child: Text("Upload Image")),
      )),
    );
  }
}
