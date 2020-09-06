import 'HomePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart'; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 


class UploadPage extends StatefulWidget
{
  State<StatefulWidget> createState()
  {
    return _UploadPageState();
  }
}
class _UploadPageState extends State<UploadPage>
{
  String _myValue;
  String url;
  File sampleImage;

  final formKey = new GlobalKey<FormState>();

  Future getItem() async
  {
    var temp=await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage=temp;
    });
  }

  bool validateAndSave()
  {
    final form = formKey.currentState;
    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
  }
  void uploadStatusImage() async
  {
    if(validateAndSave())
    {
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString()+".jpg").putFile(sampleImage);

      var imageUrl= await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();
      print("Image url = "+url);
      print("our data is"+_myValue);
      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url)
  {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data =
    {
      "image": url,
      "description":_myValue,
      "date":date,
      "time":time,
    };
    ref.child("Posts").push().set(data);
  }


  void goToHomePage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)
        {
          return new HomePage();
        }
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Images"),
        centerTitle: true,
      ),
      body: new Center
        (
        child: sampleImage == null? Text("Select an Item"):enableUpload(),
//       child: sampleImage == null?enableUpload():Text("Select an Item"),

        //child :  Text(sampleImage == null ? '' : enableUpload()),
        //child :  Text(sampleImage ?? enableUpload())//:enableUpload()

        //child: new Text(sampleImage!=null?enableUpload():'Default Value'),
        //child : Text('$sampleImage'),
        // print($sampleImage);
      ),

      floatingActionButton: new FloatingActionButton(onPressed: getItem,
        tooltip: 'Add Item',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload()
  {
    return Container(
      child: new Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage,height: 199.0,width: 660,),
            SizedBox(height: 15.0,),
            TextFormField(
              decoration: new InputDecoration(labelText: "Description"),
              validator: (value){
                return value.isEmpty? 'Image Description is required':null;
              },
              onSaved: (value){

                _myValue=value;
                return _myValue;
              },
            ),

            SizedBox(height: 15.0,),
            RaisedButton(
              elevation: 10.0,
              child: Text("Add a new Post"),
              textColor: Colors.white,
              color: Colors.pink,

              onPressed: uploadStatusImage,

            ),

          ],
        ),
      ),
    );
  }
}
