import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/pages/camera_page.dart';
import 'package:snapchat_ui_clone/pages/chat_page.dart';
import 'package:snapchat_ui_clone/pages/discover_page.dart';
import 'package:snapchat_ui_clone/pages/map_page.dart';
import 'package:snapchat_ui_clone/pages/stories_page.dart';
import 'package:snapchat_ui_clone/theme/colors.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 2;

  List<Widget> pages = [
    MapPage(),
    ChatPage(),
     CameraPage(),
     StoriesPage(),
    DiscoverPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    // return pages.elementAt(pageIndex);
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List iconItems = [
      Feather.map_pin,
      MaterialIcons.chat_bubble_outline,
      Feather.camera,
      Feather.users,
      Feather.menu
    ];
    List textItems = ["Map", "Chat", "Camera", "Stories", "Discover"];
    List colorItems = [
      green,
      blue,
      primary,
      purple,
      primary,
    ];
    return Container(
      width: double.infinity,
      height: 77,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
              top:
                  BorderSide(width: 2, color: Colors.black.withOpacity(0.06)))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(textItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Column(
                  children: [
                    Icon(iconItems[index],
                        color: pageIndex == index
                            ? colorItems[index]
                            : Colors.white.withOpacity(0.5)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: pageIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5)),
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }  
}