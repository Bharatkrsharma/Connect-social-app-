
import 'package:connectapp/core/utility/get_postId.dart';
import 'package:connectapp/presentation/auth/login_screen.dart';
import 'package:connectapp/presentation/profile/widgets/profile_header_card.dart';
import 'package:connectapp/presentation/profile/widgets/profile_post_card.dart';
import 'package:connectapp/presentation/profile/widgets/profile_reels_cards.dart';
import 'package:connectapp/presentation/profile/widgets/profile_save_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          //leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
          backgroundColor: Color(0xFF181818),
          title: Text("Profile"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Badge(
                textColor: Colors.white,
                label: Text("5"),
                child: Icon(Icons.notifications),
              ),
            ),
            userId== FirebaseAuth.instance.currentUser!.uid ?
            PopupMenuButton(
              child: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => LoginView()),
                          ),
                        );
                      },
                    ),
                  ),
                ];
              },
            ):
            Text(""),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              ProfileHeaderCard(
                userId: userId,
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.add_a_photo),
                  ),
                  Tab(
                    icon: Icon(Icons.play_circle_outline),
                  ),
                  Tab(
                    icon: Icon(Icons.bookmark_outline),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ProfilePostCards(),
                    ProfileReelsCards(),
                    FutureBuilder<List<String>>(
                      future: getPostIds(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ProfileSaveCards(
                                userId: userId,
                                //FirebaseAuth.instance.currentUser!.uid,
                                postId: snapshot.data![index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}