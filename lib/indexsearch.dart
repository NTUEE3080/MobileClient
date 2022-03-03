import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'Indexes.dart';
import 'package:coursecupid/IndexInformation.dart';

// index
class IndexList extends StatefulWidget {

  // states
  final List<Index> indexes;

  // constructor
  const IndexList({Key? key, required this.indexes}) : super(key: key);

  @override
  _IndexListState createState() => _IndexListState();
}

class _IndexListState extends State<IndexList> {


  // constants
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Icon _searchIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text('Index List');

  // States
  final TextEditingController _controller = TextEditingController();


  String _searchText = ""; // What user has typed

  List<Index> _suggestions = []; // full list (obtain from somewhere)
  List<Index> filteredIndexes = []; // filtered (display this)


  // constructor
  @override
  void initState() {
    _suggestions = widget.indexes;

    //_suggestions.addAll(generateWordPairs().take(1000));
    filteredIndexes = _suggestions;


    // _controller.addListener(() {
    //   if (_controller.text.isEmpty) {
    //     setState(() {
    //       _searchText = "";
    //       filteredIndexes = List.from(_suggestions);
    //     });
    //   } else {
    //     setState(() {
    //       filteredIndexes.clear();
    //       _searchText = _controller.text;
    //       for (var suggestion in _suggestions) {
    //         if (suggestion.asLowerCase.contains(_searchText.toLowerCase())) {
    //           filteredIndexes.add(suggestion);
    //         }
    //       }
    //       debugPrint(_searchText);
    //     });
    //   }
    // });
    super.initState();

  }

  // behaviour

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        appBarTitle = TextField(
          controller: _controller,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        appBarTitle = const Text('Index List');
        //filteredNames = _suggestions;
        _controller.clear();
      }
    });
  }

  // how to convert state into a widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        leading: GestureDetector(
          onTap: () {
            // ignore: avoid_print
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // ignore: avoid_print
              print("Tapped");
              _searchPressed();
            },
            child: _searchIcon,
          )
        ],
      ),

      body: Column(
        children: [
          GestureDetector(
              child: Text('12345'),
            onTap: (){

              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (ctxt) => indexinformation()));
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );

  }


}