import 'dart:developer';
import 'package:exam_adv/model/receipe_model.dart';
import 'package:exam_adv/helper/firestore_service.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          "Favourite Page",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService.fireStoreService.fetchFavData(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          log('$data');
          List allDocs = data?.docs ?? [];
          List<ReceipeModel> allRecipeData = allDocs
              .map(
                (e) => ReceipeModel.mapToModel(e.data()),
              )
              .toList();

          // ReceipeModel modal = ReceipeModel.mapToModel(data?.data() ?? {});
          return ListView.builder(
            itemCount: allRecipeData.length,
            itemBuilder: (context, index) {
              var recipeInfo = allRecipeData[index];
              return Card(
                surfaceTintColor: Colors.teal,
                // color: Colors.blueAccent,
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: ListTile(
                  title: Text(recipeInfo.name ?? ""),
                  subtitle: Text(recipeInfo.des ?? ""),
                  trailing: IconButton(
                    onPressed: () {
                      FirestoreService.fireStoreService.deleteFav(
                          modal: ReceipeModel(
                              id: recipeInfo.id,
                              name: recipeInfo.name,
                              des: recipeInfo.des));
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
