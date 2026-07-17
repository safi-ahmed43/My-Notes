import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_notes/providers/note/note_provider.dart';
import 'package:my_notes/utils/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController title=TextEditingController();
  TextEditingController desc=TextEditingController();
  GlobalKey<FormState> formKeys=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new note'),
      ),
      body: Form(
        key: formKeys,
        child: ListView(
          padding: EdgeInsets.all(12),
            children: [
              CustomTextField(
                  controller: title,
                  hintText: 'Enter the title',
                validator: (value) {
                    if(value== null || value.isEmpty){
                      return 'Please enter a title';
                    }
                    return null;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                  controller: desc,
                  hintText: 'Enter the descriptions',
                  maxLine: 4,
                  validator: (value) {
                    if(value== null || value.isEmpty){
                      return 'Please enter a descriptions';
                    }
                    return null;
                  },
              ),
              SizedBox(height: 20,),
              Consumer<NoteProvider>(
                builder: (context,provider,child) {
                  return provider.isLoading? Center(child:LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blueAccent,
                      size: 50),
                  ):
                  ElevatedButton(
                      onPressed: () async{
                        if(formKeys.currentState!.validate()){
                          await provider.addNote(title.text, desc.text);
                        }
                      },
                      child: Text('Saved Note')
                  );
                }
              )

            ],
        ),
      ),
    );
  }
}
