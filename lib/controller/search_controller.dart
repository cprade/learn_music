import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_music/model/raw_model/song.dart';
import 'package:learn_music/model/services/music_handler.dart';
import 'package:learn_music/model/services/shared_handler.dart';
import 'package:learn_music/views/cells/classic_tile.dart';

class SearchController extends StatefulWidget {
  const SearchController({super.key});

  @override
  SearchControllerState createState() => SearchControllerState();
}

class SearchControllerState extends State<SearchController> {
  List<String> lastSearchedSongs = [];
  List<Song> searchResults = [];

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    getSharedPref();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 75,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    onChanged: search,
                    onSubmitted: save,
                    decoration: const InputDecoration(
                      hintText: "Entrez quelque chose",
                    ),
                  ),
                ),
                IconButton(onPressed: onPressed, icon: Icon(Icons.send))
              ],
            ),
          ),
          Text(
            (textEditingController.text == "")
                ? "Dernière recherches"
                : "Nous avons trouvé pour vous",
            style: GoogleFonts.signika(color: Colors.red, fontSize: 20),
          ),
          Expanded(
              child: (textEditingController.text == "")
                  ? emptyWidget()
                  : onSearchWidget())
        ],
      ),
    );
  }

  Widget emptyWidget() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final String value = lastSearchedSongs[index];
          return ListTile(
            title: Text(value),
            onTap: (() => onTap(value)),
            onLongPress: (() => remove(value)),
          );
        },
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: lastSearchedSongs.length);
  }

  Widget onSearchWidget() {
    return ListView.separated(
        itemBuilder: ((context, index) =>
            ClassicTile(playlist: searchResults, index: index)),
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: searchResults.length);
  }

  onTap(String value) {
    textEditingController.text = value;
    search(value);
  }

  closeKeyBoard() => FocusScope.of(context).requestFocus(FocusNode());

  onPressed() {
    closeKeyBoard();
    if (textEditingController.text != "") save(textEditingController.text);
  }

  search(String string) {
    final result = MusicHandler().researche(string);
    setState(() {
      searchResults = result;
    });
  }

  save(String value) {
    SharedHandler().addItemToList(value).then((success) => getSharedPref());
  }

  getSharedPref() {
    SharedHandler().getList().then((newList) => {
          setState(
            () {
              lastSearchedSongs = newList;
            },
          ),
        });
  }

  remove(String value) {
    SharedHandler().removeItemToList(value).then((success) => getSharedPref());
  }
}
