import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_william/Constants.dart';
import 'package:startup_william/RandomWords.dart'; // Add this line.

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(12));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase, style: Constants.biggerFont),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.grey,
      ),
      onTap: () {
        setState(() => alreadySaved ? _saved.remove(pair) : _saved.add(pair));
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles = _saved.map(
                      (WordPair pair) {
                    return ListTile(
                        title: Text(
                            pair.asPascalCase, style: Constants.biggerFont)
                    );
                  }
              );
              final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

              return new Scaffold(
                  appBar: AppBar(title: Text("Saved Suggestions")),
                  body: new ListView(children: divided,)
              );
            }
        )
    );
  }

  AppBar _buildAppBar() {
    var appBar = new AppBar(
      title: const Text('William - Flutter Test'),
      actions: <Widget>[
        new IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
      ],
    );

    return appBar;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildSuggestions(),
    );
  }
}
