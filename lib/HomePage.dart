import 'files.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'posts.dart';
import 'chat_screen.dart';
import 'Upload.dart';


//void main() => runApp(HomePage());

class HomePage extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>
{
  List <PostedC> postedList = [];

  @override
  void initState() {
    // TODO: implement noSuchMethod
    super.initState();
    DatabaseReference postCRef = FirebaseDatabase.instance.reference().child("Posts"); 

    postCRef.once().then((DataSnapshot snap)
        {
          var keys = snap.value.keys;
      var data = snap.value;

      postedList.clear();

      for(var individualKey in keys)
        {
          PostedC posts = new PostedC
            (
              data[individualKey]['image'],
              data[individualKey]['description'],
              data[individualKey]['date'],
              data[individualKey]['time'],
          );

          postedList.add(posts);
        }
      setState(() {
        print("Length : $postedList.Length");
      });
        });
  }

  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar
        (
        title: new Text("Home"),
        centerTitle : true,
      ),
      backgroundColor:Colors.white,
      body: new Container(

        child: postedList.length==0 ?  new Text(("No blog Post available")) : new ListView.builder
          (
          itemCount: postedList.length,
          itemBuilder: (_,index)
            {
              return postsU(postedList[index].image,postedList[index].description,postedList[index].date,postedList[index].time);
            }
        ),
      ),

      bottomNavigationBar: new BottomAppBar(
        color:Colors.orange,
        child: new Container(

            margin: const EdgeInsets.only(left: 40.0 , right: 40.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,

              children: <Widget>[

                new IconButton(
                  icon: new Icon(Icons.account_circle ),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),

                new IconButton(
                  icon: new Icon(Icons.person),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),

                new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push
                      (
                        context,MaterialPageRoute(builder: (context)
                    {
                      return new UploadPage();
                      //return new MyApp();
                    }
                    )
                    );
                  },
                ),

                new IconButton(
                  icon: new Icon(Icons.folder),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push
                      (
                        context,MaterialPageRoute(builder: (context)
                    {
                      //return new UploadPage();
                      return new MyApp();
                    }
                    )
                    );
                  },
                ),



                new IconButton(
                  icon: new Icon(Icons.chat),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                ),


              ],

            )
        ),
      ),
    );
  }
  Widget postsU(String image,String description,String date,String time)
  {
    return new Card
      (
          elevation : 10.0,
          margin : EdgeInsets.all(15.0),

        child:new Container
          (
           padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    time,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),

              SizedBox(height: 10.0,),
              new Image.network(image,fit: BoxFit.cover,),
              SizedBox(height: 10.0,),
              new Text(
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),

            ],
          ),


        ),

    );

  }
}

