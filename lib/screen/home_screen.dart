import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String formatCount(int count) {
    if (count >= 1000000) {
      return (count / 1000000).toStringAsFixed(1) + "M";
    } else if (count >= 1000) {
      return (count / 1000).toStringAsFixed(1) + "K";
    } else {
      return count.toString();
    }
  }

  void openCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 🔥 important (full screen)
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9, // open 90%
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  // 🔘 TOP HANDLE
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // 📝 TITLE
                  Text(
                    "Comments",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  Divider(),

                  // 💬 COMMENTS LIST
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/rkk.png"),
                          ),
                          title: Text("User $index"),
                          subtitle: Text("Nice post 🔥"),
                        );
                      },
                    ),
                  ),

                  // ✍️ INPUT FIELD
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Write a comment...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF7B61FF);

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),

      // 🔻 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, size: 30),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // 🔝 HEADER
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔍 Search
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.search),
                  ),

                  // 🖼️ Logo
                  Text(
                    "InstaClone",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // 🔔 Notification
                  Stack(
                    children: [
                      Icon(Icons.notifications_none, size: 28),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 📸 STORIES
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("assets/rkk.png"),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("User"),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🎯 FILTERS
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _filter("New", true),
                  _filter("Nearby", false),
                  _filter("Following", false),
                  _filter("Connect", false),
                ],
              ),
            ),

            SizedBox(height: 10),

            // 📰 POSTS
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _postCard(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔘 FILTER CHIP
  Widget _filter(String text, bool selected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Color(0xFF7B61FF) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: selected ? Colors.white : Colors.black),
      ),
    );
  }

  // 📰 POST CARD
  Widget _postCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // 👤 USER INFO
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/rkk.png"),
            ),
            title: Text("Username"),
            subtitle: Text("2 min ago"),
            trailing: Icon(Icons.more_vert),
          ),

          // 📸 IMAGE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/rkk.png",
                height: 370,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ❤️ ACTIONS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // ❤️ LIKE
                    Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 5),
                        Text(formatCount(75200)), // 75.2K
                      ],
                    ),

                    SizedBox(width: 20),

                    // 💬 COMMENT
                    GestureDetector(
                      onTap: () {
                        openCommentSheet(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.comment_outlined),
                          SizedBox(width: 5),
                          Text(formatCount(3250)), // 3.2K
                        ],
                      ),
                    ),

                    SizedBox(width: 20),

                    // 🔁 SHARE
                    Row(
                      children: [
                        Icon(Icons.share_outlined),
                        SizedBox(width: 5),
                        Text(formatCount(1118)), // 1.1K
                      ],
                    ),
                  ],
                ),

                // 📌 SAVE
                Icon(Icons.bookmark_border),
              ],
            ),
          ),
          SizedBox(height: 5),

          // 📝 CAPTION
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("This is a sample post caption 💜"),
            ),
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}
