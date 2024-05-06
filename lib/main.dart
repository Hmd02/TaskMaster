import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TaskMaster'),
    );
  }
}

class ListItem {
  String title = "head";
  String subtitle = "Body";
  bool hasCompleted = true;

  ListItem(String title, String subtitle, bool hasCompleted) {
    this.title = title;
    this.subtitle = subtitle;
    this.hasCompleted = hasCompleted;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  bool selected = false;
  final List<int> _selectedItems = [];
  final List<ListItem> items = [];

// need 2 values to store for each item
// subtitle,boolean
// once user clicks a checkbox , boolean value should change for that index
// once user click edit ,subitile value should change
// once user clicks add Card must be added to screen with default values
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      items.insert(0, ListItem("Title..", "Subtitle..", false));
    });
  }

  void handlePress(int index) {
    setState(() => _selectedItems.add(index));
  }

  void handleDismiss(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

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
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Container(
              alignment: const Alignment(0, 1),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
              )),
        ),
        body: items.length >= 1
            ?Column(children: [
              Container(height: 10,),
              Container(alignment:Alignment(0, 0) ,child: Text("Swipe right -> to delete",style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.6),fontStyle: FontStyle.italic),)),
             Expanded(child:ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      ListItem item = items[index];
                      return Card(
                        key: UniqueKey(),
                        child: EditableItem(
                            model: item,
                            index: index,
                            handleDismiss: handleDismiss),
                      );
                    })
             )
            ],)
           
              
            : Container(
                alignment: Alignment(0, 0),
                child: Text(
                  "Click + to add",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.6),
                      fontStyle: FontStyle.italic),
                )),
        floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Add Item',
            child: const Icon(Icons.add)));
    // This trailing comma makes auto-formatting nicer for build methods.):null;
  } //Widget
}

class EditableItem extends StatefulWidget {
  ListItem model;
  int index;

  var handleDismiss;

  EditableItem(
      {super.key,
      required this.model,
      required this.index,
      required this.handleDismiss});
  @override
  State<EditableItem> createState() => _EditableItemState();
}

class _EditableItemState extends State<EditableItem> {
  late ListItem item;
  late bool isEditMode;
  late TextEditingController titleController, subTitleController;

  @override
  void initState() {
    super.initState();
    item = widget.model;
    titleController = TextEditingController(text: item.title);
    subTitleController = TextEditingController(text: item.subtitle);
    isEditMode = false;
  }

  void toggleMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  void save() {
    item.title = titleController.text;
    item.subtitle = subTitleController.text;
    toggleMode();
  }

  @override
  Widget build(BuildContext context) {
    return isEditMode
        ? ListTile(
            title: TextField(
              controller: titleController,
            ),
            subtitle: TextField(controller: subTitleController),
            trailing:
                IconButton(onPressed: save, icon: const Icon(Icons.check)),
          )
        : Dismissible(
            key: ValueKey<String>(item.subtitle),
            background: Container(
              color: Colors.red,
              alignment: Alignment(-0.75, 0),
              child: Icon(Icons.delete_forever_rounded),
            ),
            onDismissed: (DismissDirection direction) {
              widget.handleDismiss(widget.index);
            },
            child: ListTile(
                title: Text(titleController.text),
                subtitle: Text(subTitleController.text),
                trailing: SizedBox(
                    width: 75,
                    child: Row(
                      children: [
                        Expanded(
                            child: Checkbox(
                          value: item.hasCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              item.hasCompleted = !item.hasCompleted;
                            });
                          },
                        )),
                        IconButton(
                            onPressed: toggleMode, icon: const Icon(Icons.edit))
                      ],
                    ))));
  }
}
