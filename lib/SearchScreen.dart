import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:loginapp/HistoryScreen.dart';
import 'package:loginapp/models/Datbase.dart';
import 'package:loginapp/models/dictionary_model.dart';
import 'package:loginapp/service.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  DictionaryModel? myDictionaryModel;
  bool isLoading = false;

  

  String noDataFound = " Now You Can Search";
DBHandler Db=DBHandler();
  searchContain(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      myDictionaryModel = await APIservices.fetchData(word);
      print("before insert------------------------------------------");

      setState(() {Db.insertData(word);
      print(word);
print("after insert--------------------------------------------------");});
    } catch (e) {
      myDictionaryModel = null;
      noDataFound = "Meaning can't be found";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
        title: Text("Shabdkosh"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.blueGrey,
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => HistoryScreen(),));
          }, icon:Icon(Icons.history)),
        

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
          
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search the word here",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: (value) {
                  searchContain(value);
                },
              ),
            ),
            const SizedBox(height: 10),
            if (isLoading)
              const LinearProgressIndicator()
            else if (myDictionaryModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      myDictionaryModel!.word,
                      
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      myDictionaryModel!.phonetics.isNotEmpty
                          ? myDictionaryModel!.phonetics[0].text ?? ""
                          : "",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictionaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          return showMeaning(myDictionaryModel!.meanings[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
              else
              Center(
                child: Text(
                  noDataFound,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
          ],
        ),
      ),
    );
  }

  
}

Widget showMeaning(Meaning meaning) {
  String wordDefinition = "";
  for (var element in meaning.definitions) {
    int index = meaning.definitions.indexOf(element);
    wordDefinition += "\n${index + 1}. ${element.definition}\n";
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.partOfSpeech,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Definitions:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              wordDefinition,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}




