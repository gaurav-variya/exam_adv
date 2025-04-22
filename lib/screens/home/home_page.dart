import 'dart:developer';
import 'package:exam_adv/controller/home_controller.dart';
import 'package:exam_adv/model/receipe_model.dart';
import 'package:exam_adv/routes/app_pages.dart';
import 'package:exam_adv/helper/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  // @override
  // void initState() {
  //   super.initState();
  //   controller.fetchData(); // Load data when HomePage starts
  // }

  @override
  Widget build(BuildContext context) {
    // controller.fetchData();
    controller.fetchData();
    TextEditingController nameController = TextEditingController();
    TextEditingController desController = TextEditingController();

    TextEditingController editRecName = TextEditingController();
    TextEditingController editRecDes = TextEditingController();
    GlobalKey<FormState> editReceipeForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          "Home Page",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.favorite);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              )),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.allReceipe.isEmpty) {
            return Center(
              child: Text(
                "Please add recipe...",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: controller.allReceipe.length,
              itemBuilder: (context, index) {
                var recipeData = controller.allReceipe![index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          controller.deleteData(recipeData.id!);
                        },
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(12),
                        // spacing: 10
                        // flex: 2,
                        label: "Delete",
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          editRecName.text = recipeData.name!;
                          editRecDes.text = recipeData.des!;
                          Get.bottomSheet(
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  topLeft: Radius.circular(22),
                                ),
                              ),
                              child: Form(
                                key: editReceipeForm,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: editRecName,
                                        validator: (value) => value!.isEmpty
                                            ? "Recipe name is required"
                                            : null,
                                        decoration: InputDecoration(
                                          labelText: 'Receipe name',
                                          hintText: 'Enter receipe name',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: editRecDes,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          labelText: 'Description',
                                          hintText: 'Enter description',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () {
                                          if (editReceipeForm.currentState!
                                              .validate()) {
                                            controller.updateData(
                                              ReceipeModel(
                                                  id: recipeData.id,
                                                  name: editRecName.text,
                                                  des: editRecDes.text),
                                            );
                                            Get.back();
                                            editRecDes.clear();
                                            editRecName.clear();
                                            // Navigator.pop(context);
                                          } else {
                                            Get.snackbar(
                                              'Failed',
                                              'Please enter all details',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                        label: Text("SAVE"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.all(16),
                        spacing: 10,
                        borderRadius: BorderRadius.circular(12),
                        label: "Edit",
                      ),
                    ],
                  ),
                  child: Card(
                    surfaceTintColor: Colors.teal,
                    // color: Colors.blueAccent,
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(recipeData.name ?? ""),
                      subtitle: Text(recipeData.des ?? ""),
                      trailing: IconButton(
                        onPressed: () {
                          FirestoreService.fireStoreService.allFavRecipe(
                            modal: ReceipeModel(
                                id: recipeData.id,
                                name: recipeData.name,
                                des: recipeData.des),
                          );
                        },
                        icon: Icon(Icons.favorite),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Recipe ',
            content: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter recipe name',
                    labelText: 'Name',
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: desController,
                  decoration: InputDecoration(
                    hintText: 'Enter recipe description',
                    labelText: 'Description',
                    // border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                // Text("Receipes"),
              ],
            ),
            cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("CANCEL"),
            ),
            confirm: ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String des = desController.text;
                controller.insertData(name, des);
                Get.back();
                nameController.clear();
                desController.clear();
              },
              child: Text("SAVE"),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
