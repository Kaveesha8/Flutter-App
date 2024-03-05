import 'package:flutter/material.dart';
import 'package:webapp/screens/addUser.dart';
import 'package:webapp/api_handler.dart';
import 'package:webapp/screens/editUser.dart';
import 'package:webapp/screens/finduser.dart';
import 'package:webapp/models/model.dart';
import 'package:webapp/widgets/myAppBar.dart';
import 'package:webapp/widgets/myNavigationBar.dart';
 
class MainPage extends StatefulWidget {
  const MainPage({super.key});
 
  @override
  State<MainPage> createState() => _MainPageState();
}
 
class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler(); //instance of the api handler class
  late List<User> data = [];
 
  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {
      // set state refresh the page
    });
    print(data);
  }
 
  void deleteUser(int userId) async{
    await apiHandler.deleteUser(userId: userId);
    setState(() {
     
    });
  }
 
  @override
  void initState() {
    getData();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'My Custom App Bar'),
      //appBar: const MyAppBar(title: "Api"),
      // appBar: AppBar(
      //   title: const Text("FlutterApi"),
      //   centerTitle: true,
      //   backgroundColor: Colors.teal,
      //   foregroundColor: Colors.white,
      // ),
      bottomNavigationBar: MyNavigationBar(title: 'Refresh', executeFunction: getData),
      // bottomNavigationBar: MaterialButton(
      //   color: Colors.teal,
      //   textColor: Colors.white,
      //   padding: const EdgeInsets.all(20),
      //   onPressed: getData,
      //   child: const Text("Refresh"),
      // ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FindUser()),
          );
            },
            child: const Icon(
              Icons.search,
            ),
          ),
          const SizedBox(height: 10,),
      FloatingActionButton(
        heroTag: 2,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUser()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
        ],
      ),
     
      body: Column(
       
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(user: data[index])),
                  );
                },
                leading: Text("${data[index].id}"),
                title: Text(data[index].name),
                subtitle: Text(data[index].addresss),
                trailing: IconButton(
                  onPressed: () {
                    deleteUser(data[index].id);
                    getData(); // reload the data
                  },
                  icon: const Icon(Icons.delete_outlined),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
 