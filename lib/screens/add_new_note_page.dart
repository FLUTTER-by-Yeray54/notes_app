import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/widgets/toast.dart';

import '../controller/note_controller.dart';

class AddNewNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.titleController.text = "";
    controller.contentController.text = "";
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.titleController,
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: "Título",
            hintStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColor.hintColor,
            ),
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [

              TextField(
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: controller.contentController,
                decoration: const InputDecoration(
                  hintText: "Escribe la nota aqui...",
                  hintStyle: TextStyle(
                    fontSize: 22,
                    color: AppColor.hintColor,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.titleController.text.isEmpty) {
            showToast(message: "Titulo vacio");
          }  else {
            controller.addNoteToDatabase();
          }
        },
        label: const Text(
          "Crear Nota",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        icon: const Icon(
        Icons.save,
        color: Colors.white,
      ),
        backgroundColor: const Color.fromRGBO(111, 183, 214, 50),
      ),
    );
  }
}
