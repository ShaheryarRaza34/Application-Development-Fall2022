import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Product>productList=[
    Product(
      productName: "Product 1",
      productQuantity: 0,
      isSelected: false,
    ),
    Product(productName: "Product 2", productQuantity: 0,isSelected: false,)
  ];
  List<Product>selectedProducts=[];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Products",
        style: TextStyle(color:Colors.black),),
        backgroundColor: Colors.white,
      ),
      body:ListView.builder(
        itemBuilder: (BuildContext, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                //backgroundImage: AssetImage(productList[index].productName),
               ),
              title:Text(productList[index].productName),
              subtitle:Text("This is subtitle"),
              trailing: (productList[index].isSelected==false?IconButton(
                  onPressed:
                  (){
                    setState(() {
                      productList[index].isSelected=true;
                      productList[index].productQuantity++;
                      selectedProducts.add(productList[index]);
                    });
                  }

                   , icon: Icon(Icons.add)):counterRow(productList: productList,index: index,selectedProducts: selectedProducts,))


          )
          );
        },
        shrinkWrap: true,
        itemCount: productList.length,
        padding: EdgeInsets.all(10),
      ),

              






      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Text("Cart("+selectedProducts.length.toString()+")"),


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class Product{
  final String productName;
   int productQuantity;
   bool isSelected;
  Product({
    required this.productName,
    required this.productQuantity,
    required this.isSelected,

});
  void _incrementProduct(Product product) {
    product.productQuantity++;

    ;
  }
  void _decrementProduct(Product product) {
    if(product.productQuantity>1) {
      product.productQuantity--;
    }
    else{
      if(product.productQuantity==1){
        product.isSelected=false;
        product.productQuantity--;

      }
    }
  }


}
class counterRow extends StatefulWidget {
  const counterRow({Key? key,required this.productList,required this.index,required this.selectedProducts}) : super(key: key);
  final int index;
  final List<Product> productList;
  final List<Product> selectedProducts;
  @override
  State<counterRow> createState() => _counterRowState();
}

class _counterRowState extends State<counterRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              widget.productList[widget.index]._incrementProduct(widget.productList[widget.index]);
            });

            //print(productList[index].productQuantity);
          },
          icon:Icon(Icons.add_circle),

        ),
        Text(widget.productList[widget.index].productQuantity.toString()),
        IconButton(
          onPressed: (){
            setState(() {
              if(widget.productList[widget.index].productQuantity==1){
                widget.productList[widget.index].isSelected=false;
                widget.productList[widget.index].productQuantity--;
                widget.selectedProducts.remove(widget.productList[widget.index]);


              }
              else {
                widget.productList[widget.index]._decrementProduct(
                    widget.productList[widget.index]);
              }

            });

            //print(productList[index].productQuantity);
          },
          icon:Icon(Icons.remove_circle),

        ),
      ],
    );
  }
}

