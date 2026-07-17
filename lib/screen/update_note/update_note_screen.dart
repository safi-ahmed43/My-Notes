import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_notes/models/note/note_model.dart';
import 'package:provider/provider.dart';

import '../../providers/note/note_provider.dart';
import '../../utils/widgets/custom_textfield.dart';

class UpdateNoteScreen extends StatefulWidget {
  final NoteModel note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController title=TextEditingController();
  TextEditingController desc=TextEditingController();
  GlobalKey<FormState> formKeys=GlobalKey<FormState>();

  @override
  void initState() {
    title.text=widget.note.title!;
    desc.text=widget.note.desc!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update your note'),
      ),
      body:  Form(
        key: formKeys,
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            CustomTextField(
              controller: title,
              hintText: 'title',
              validator: (value) {
                if(value== null || value.isEmpty){
                  return 'Please enter a new title';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            CustomTextField(
              controller: desc,
              hintText: 'Descriptions',
              maxLine: 4,
              validator: (value) {
                if(value== null || value.isEmpty){
                  return 'Please enter a new descriptions';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            Consumer<NoteProvider>(
                builder: (context,provider,child) {
                  return provider.isLoading?
                  Center(child:LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blueAccent,
                      size: 50),
                  ):
                  ElevatedButton(
                      onPressed: () async{
                        if(formKeys.currentState!.validate()){
                          provider.updateNote(title.text, desc.text, widget.note.id!);
                        }
                      },
                      child: Text('Update Note')
                  );
                }
            )

          ],
        ),
      ),
      );
  }
}
