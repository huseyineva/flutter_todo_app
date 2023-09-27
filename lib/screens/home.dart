import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/carditem.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor(backgroundColor),
            body: Column(
              children: [
                Container(
                  width: phoneWidth,
                  height: phoneHeight / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/assets/images/header.png"),
                          fit: BoxFit.cover)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(formattedDate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("My Todo List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: todoService.getUnCompletedTodos(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Carditem(
                                  task: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text("Completed",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: todoService.getCompletedTodos(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            return ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Carditem(
                                  task: snapshot.data![index],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddNewTaskScreen(),
                        ),
                      );
                    },
                    child: const Text("Add New Task")),
              ],
            ),
          ),
        ));
  }
}
