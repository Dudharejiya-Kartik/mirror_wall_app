import 'package:flutter/material.dart';
import '../../../provider/web_provider.dart';
import 'browser.dart';

AppBar WebViewAppBar(
    WebProvider providerTrue, WebProvider providerFalse, BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xff121212),
    toolbarHeight: 90,
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.account_circle_outlined,
        color: Colors.white,
        size: 30,
      ),
    ),
    leadingWidth: 30,
    title: SizedBox(
      height: 41,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: providerTrue.textEditingController,
        onSubmitted: (value) {
          providerFalse.updateSearchedText(value);
          providerFalse.searchAtSelectedSearchEngine();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xff343039),
          contentPadding: const EdgeInsets.only(top: 5, left: 15),
          hintText: "Search Here",
          hintStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            providerFalse.addBookmark();
          },
          icon: const Icon(
            Icons.star_border_purple500_outlined,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.file_download_outlined,
            color: Colors.white,
          )),
      PopupMenuButton(
        iconColor: Colors.white,
        color: const Color(0xff332940),
        shadowColor: Colors.black,
        surfaceTintColor: const Color(0xff302836),
        elevation: 20,
        onSelected: (value) {
          if (value == "Bookmarks") {
            Navigator.of(context).pushNamed('/bookmark');
          } else if (value == "Browser") {
            showDialog(
              context: context,
              builder: (context) => const BrowserDialog(),
            );
          } else {
            Navigator.of(context).pushNamed('/history');
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'Bookmarks',
            child: ListTile(
              leading: const Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
              title: Text('Bookmarks',
                  style: TextStyle(color: Colors.grey.shade300)),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Browser',
            child: ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              title: Text('Browser',
                  style: TextStyle(color: Colors.grey.shade300)),
            ),
          ),
          PopupMenuItem<String>(
            value: 'History',
            child: ListTile(
              leading: const Icon(
                Icons.history,
                color: Colors.grey,
              ),
              title: Text(
                'History',
                style: TextStyle(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
