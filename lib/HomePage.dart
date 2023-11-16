import 'package:bard_flutter/BardAIController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BardAIController controller = Get.put(BardAIController());
  TextEditingController textField = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.sendPrompt(firtPrompt: "You are going to introduce yourself as Mary, what questions could I help you with about Kartagene syndrome. Got it pretend to be a bot Maria who talks about Kartagene syndrome");
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Color(0xfff2f1f9),
      appBar: AppBar(
        centerTitle: true,
        leading: SvgPicture.asset(
          "assets/bard_logo.svg",
          width: 10,
        ),
        title: const Text(
          "MARIA",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        backgroundColor: Colors.white,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         controller.sendPrompt("You are going to introduce yourself as Mary, what questions could I help you with about Kartagene syndrome. Got it pretend to be a bot Maria who talks about Kartagene syndrome");
        //       },
        //       icon: Icon(Icons.security))
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child:
                //           Text("Welcome to flutter hero ask some thing  ❤️ "),
                //     ),
                //   ],
                // ),
                SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Text(
                //           "😍 How can i be a best software developer in just"),
                //     ),
                //   ],
                // ),
                SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       padding:
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Text("Flutter Getx Full video💡 "),
                //     ),
                //   ],
                // ),
                Obx(() => Column(
                      children: controller.historyList
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color:e.system == 'user'? Colors.white : Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(e.system == "user" ? "👨‍💻" : "🤖"),
                                  SizedBox(width: 10),
                                  Flexible(child: Text( e.message,style: TextStyle(fontWeight: e.system == 'user'? null : FontWeight.bold),)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ))
              ],
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: textField,
                    decoration: InputDecoration(
                        hintText: "Converse comigo!",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : IconButton(
                          onPressed: () {
                            if (textField.text != "") {
                              controller.sendPrompt(prompt: textField.text);
                              textField.clear();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                ),
                SizedBox(width: 10)
              ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
