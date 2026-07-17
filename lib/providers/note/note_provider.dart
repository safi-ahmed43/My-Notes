import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/models/note/note_model.dart';
import 'package:my_notes/utils/widgets/show_message.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> notes = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;
  String? deleteNoteId;
  String userName = '';
  String userEmail = '';

  Future<void> getName() async {
    if (auth.currentUser == null) return;

    try {
      final userDoc = await db
          .collection('user')
          .doc(auth.currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        userName = userDoc.data()!['name'] ?? 'No Name';
        userName = userDoc.data()!['email'] ?? 'No Email';
      }
    } catch (e) {
      print("Error fetching name: $e");
    }
  }

  void getNotes() async {
    _loading(true);
    try{
      final result =await db.collection('notes')
          .where('user_id', isEqualTo: auth.currentUser!.uid)
          .orderBy('created_at', descending: true)
          .get();
      await getName();
      List<NoteModel> fetchedNotes = [];
      for(var doc in result.docs){
        NoteModel note=NoteModel.formMap(doc.data());
        fetchedNotes.add(note);
      }
      notes=fetchedNotes;
    }on FirebaseException catch(e){
      showMessage(e.message ?? 'Firebase error occurred');
    }
    catch (e){
      showMessage(e.toString());
    }
    finally{
      _loading(false);
    }
  }

  Future<void> addNote(String title, String desc) async {
    _loading(true);
    String id=DateTime.now().millisecondsSinceEpoch.toString();
    try {
      NoteModel note= NoteModel(id, auth.currentUser!.uid, title, desc, DateTime.now());
      await db.collection('notes').doc(id).set(note.toMap());
      getNotes();
      Navigator.pop(navigatorKeys.currentContext!);
    } on FirebaseException catch (e) {
      showMessage(e.message ?? 'Firebase error occurred');
    } catch (e) {
      showMessage(e.toString());
    } finally {
      _loading(false);
    }

  }

  void updateNote(String title , String desc, String noteId) async{
    try {
        await db.collection('notes').doc(noteId).update({
          'title':title,
          'desc':desc
        });
        getNotes();
        Navigator.pop(navigatorKeys.currentContext!);
    } on FirebaseException catch (e) {
      showMessage(e.message);
    } catch (e) {
      showMessage(e.toString());
    } finally {}
  }

  void deleteNote(NoteModel note) async {
    deleteNoteId=note.id;
    notifyListeners();
    try {
      await db.collection('notes').doc(note.id).delete();
      notes.removeWhere((element) => element.id == note.id);
    } on FirebaseException catch (e) {
      showMessage(e.message);
    } catch (e) {
      showMessage(e.toString());
    } finally {
      deleteNoteId=null;
      notifyListeners();
    }
  }

  void _loading(bool value){
    isLoading=value;
    notifyListeners();
  }
}
