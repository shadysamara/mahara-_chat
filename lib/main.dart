import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahara_chat/firestore_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirestoreHelper.firestoreHelper.getMessages(),
              builder: (context, snapshot) {
                QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                if (data == null) {
                  return SizedBox();
                } else {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                      data.docs;
                  List<Map<String, dynamic>> docuemntsData =
                      documents.map((e) => e.data()).toList();
                  return ListView.builder(
                      itemCount: docuemntsData.length,
                      itemBuilder: (context, index) {
                        return Text(docuemntsData[index]['content']);
                      });
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      FirestoreHelper.firestoreHelper
                          .sendMessage(controller.text);
                      controller.clear();
                    },
                    child: Text('Send'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
