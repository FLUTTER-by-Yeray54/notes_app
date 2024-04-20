import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes_app/routing/app_routes.dart';

import '../controller/note_controller.dart';
import '../widgets/alert_dialog.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final int i = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(111, 183, 214, 50),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Detalles de la nota",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert, // Icono de desbordamiento de puntos verticales
              color: Colors.white, // Cambia el color del icono aquí
            ),
            onSelected: (val) {
              if (val == 0) {
                editNote(i);
              } else if (val == 1) {
                deleteNote(context, i);
              } else if (val == 2) {
                shareNote(i);
              }
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    "Editar Nota",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Borrar Nota",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Compartir",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ];
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    controller.notes[i].title!,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Ultima edición : ${controller.notes[i].dateTimeEdited}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SelectableText(
                    controller.notes[i].content!,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void editNote(int i) async {
    Get.toNamed(AppRoute.EDIT_NOTE, arguments: i);
  }

  void deleteNote(BuildContext context, int i) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          headingText: "¿De verdad quieres borrar las notas?",
          contentText:
              "Esta accion será permanente y no se podrá deshacer",
          confirmFunction: () {
            controller.deleteNote(controller.notes[i].id!);
            Get.offAllNamed(AppRoute.HOME);
          },
          declineFunction: () {
            Get.back();
          },
        );
      },
    );
  }

  void shareNote(int i) async {
    controller.shareNote(
      controller.notes[i].title!,
      controller.notes[i].content!,
    );
  }
}
