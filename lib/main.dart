import 'package:flutter/material.dart';
import 'image_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> veichelnames =[
    'elevate',
    'excavator',
    'helikopter',
    'Kapal',
    'kereta',
    'mobil',
    'motor',
    'pesawat',
    'sepeda',
  ];
  String currentVichacleName ='Veichle name';
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDracgPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;

  List<Widget> buildCards(){
    List <Widget> cardsList=[];
    for(int i=0; i < veichelnames.length; i++){
      cardsList.add(buildCard(i,scrollPercent));
    }
    return cardsList;
  }

  Widget buildCard(int cardIndex, double scrollPercent ){
    final cardScrollPercent= scrollPercent/(1/veichelnames.length);

    return FractionalTranslation(
      translation: Offset(cardIndex - cardScrollPercent, 0.0),
      child: Padding(
          padding: EdgeInsets.all(8.0),
      child: ImageCard(imageName: veichelnames[cardIndex],),
      ),
    );
  }

  void onHprizontalDragStart(DragStartDetails details){
    startDrag = details.globalPosition;
    startDracgPercentScroll = scrollPercent;
  }
  void onHprizontalDragUpdate(DragUpdateDetails details){
    final currentDrag = details.globalPosition;
    final dragDistance=currentDrag.dx-startDrag.dx;
    final singleCardDragPercent=dragDistance/context.size.width;

    setState(() {
      scrollPercent=(startDracgPercentScroll+(-singleCardDragPercent
          /veichelnames.length)).clamp(0.0, 1.0-(1/veichelnames.length));
    });
  }
  void onHprizontalDragEnd(DragEndDetails details){
    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent* veichelnames.length ).round()/ veichelnames.length;
    setState(() {
      startDrag=null;
      startDracgPercentScroll=null;
      currentVichacleName='';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: GestureDetector(
                onHorizontalDragStart: onHprizontalDragStart ,
                onHorizontalDragUpdate: onHprizontalDragUpdate,
                onHorizontalDragEnd: onHprizontalDragEnd,
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  children: buildCards(),

                ),
              ),
            ),
            OutlineButton(
              padding: EdgeInsets.all(10.0),
              onPressed: () => {},
              child: Text(
                'Show The Answer',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              borderSide: BorderSide(
                color: Colors.black,
                width: 4.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              highlightedBorderColor: Colors.black,
            ),
            Text(currentVichacleName,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
