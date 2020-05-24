import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(
  new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Scaffold(
      body: new Center(child: new MyApp(),
      )
    )
  )
);
      
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new JsonPage(),
      image: new Image.network('https://pixelbox.ru/wp-content/uploads/2018/02/funny_batman_steam_avatars.jpg'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Who i am?"),
      loaderColor: Colors.blue,
    );
  }
}

class JsonPage extends StatelessWidget {

  Future<List<Tech>> getJson(BuildContext context) async {
    String parsed = await DefaultAssetBundle.of(context).loadString("assets/techs.ruleset.json");
    List<dynamic> raw = jsonDecode(parsed);
    return raw.map((e) => Tech.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test 144"),
      ),
    body: Container(
      width: 1000,  
      height: 400,
      child: FutureBuilder(
        future: getJson(context),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Tech> data = snapshot.data;

            return Swiper(
              itemCount: data.length,
              itemBuilder: (context, index){
                return Container(
              child: Card(
                child: Wrap(
                    children: <Widget>[
                    Image.network("https://raw.githubusercontent.com/wesleywerner/ancient-tech/02decf875616dd9692b31658d92e64a20d99f816/src/images/tech/" + data[index].graphic,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,),
                    ListTile(
                      title: Text(
                    data[index].name,
                    style: TextStyle(fontSize: 25),
                    
                  ),
                  subtitle: Text(
                    data[index].helptext,
                    style: TextStyle(fontSize: 20),
                  ),
                    )
                  ],
                ),
              ),
);
                /*return TechRow(
                name: data[index].name,
                graphic: data[index].graphic,
                helptext: data[index].helptext
                ); */   
              },
              viewportFraction: 0.8,
              scale: 0.9
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    )
    );
  }
}
 

class Tech {
  String graphic;
  String name;
  String helptext;

  Tech({
      this.graphic,
      this.name,
      this.helptext
  });

  Tech.fromJson(Map<String, dynamic> json) {
    graphic = json['graphic'];
    name = json['name'];

    if(json['helptext'] != null) {
      helptext = json['helptext'];
    } else {helptext = "-";}
  }
}