//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:messageapp/auth/auth_service.dart';
import 'package:messageapp/components/my_drawer.dart';
import 'package:messageapp/components/user_tile.dart';
import 'package:messageapp/pages/chat_page.dart';
import 'package:messageapp/services/auth/auth_service.dart';
import 'package:messageapp/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 30.0,
            ),
            Text(
              " Safe",
              style: TextStyle(letterSpacing: 2.0, color: Colors.blue),
            ),
            Text(
              "Chat",
              style: TextStyle(
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        // actions: [
        //   //logout button
        //   IconButton(onPressed: logout, icon: Icon(Icons.logout))
        // ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      //stream: _authService.userStream,
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //build individual list item for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        //_emailController.text
        text: userData['email'],
        onTap: () {
          //tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverID: userData["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}

// NEW CODE FROM GEMINI

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// //import 'package:messageapp/auth/auth_service.dart';
// import 'package:messageapp/components/my_drawer.dart';
// import 'package:messageapp/components/user_tile.dart';
// import 'package:messageapp/pages/chat_page.dart';
// import 'package:messageapp/services/auth/auth_service.dart';
// import 'package:messageapp/services/chat/chat_service.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   // New, if any problem arises, delete
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   Future<UserCredential> getUserDetails(String email) async {

// //   final snapshot = await _firestore.collection("Users").get();
// //   final userData = snapshot.docs.map((e)) =>UserCredential.fromSnapshot((e)).toList();
// //   return userData;
// // }

//   // chat & auth services
//   final ChatService _chatService = ChatService();
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Home",
//         ),
//         centerTitle: true,
//         // actions: [
//         //   //logout button
//         //   IconButton(onPressed: logout, icon: Icon(Icons.logout))
//         // ],
//       ),
//       drawer: const MyDrawer(),
//       body: Column(
//         children: [
//           // Display the current user's email
//           StreamBuilder<String?>(
//             stream: _authService.userStream,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Center(
//                   child: Text('Welcome, ${snapshot.data}!'),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//           Expanded(
//             child: _buildUserList(),
//           ),
//           // Print logged-in user emails
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Logged-in User Emails:',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 for (String email in _authService.loggedInUserEmails)
//                   Text(email),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // build a list of users except for the current user
//   Widget _buildUserList() {
//     return StreamBuilder(
//       stream: _chatService.getUsersStream(),
//       //stream: _authService.userStream,
//       builder: (context, snapshot) {
//         // error
//         if (snapshot.hasError) {
//           return const Text("Error");
//         }

//         //loading...
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text("Loading...");
//         }

//         //return list view
//         return ListView(
//           children: snapshot.data!
//               .map<Widget>((userData) => _buildUserListItem(userData, context))
//               .toList(),
//         );
//       },
//     );
//   }

//   //build individual list item for user
//   Widget _buildUserListItem(
//       Map<String, dynamic> userData, BuildContext context) {
//     //display all users except current user
//     return UserTile(
//       //_emailController.text
//       text: userData['email'],
//       onTap: () {
//         //tapped on a user -> go to chat page
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(
//                 receiverEmail: userData['email'],
//               ),
//             ));
//       },
//     );
//   }
// }
