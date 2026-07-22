import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_notes/providers/auth/my_auth_provider.dart';
import 'package:my_notes/providers/note/note_provider.dart';
import 'package:my_notes/utils/Route/route_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context,listen: false).getNotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Notes'),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text('Log Out'),
                        content: const Text('Are you sure want to log out'),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('Naver')
                          ),
                          TextButton(
                              onPressed: (){
                                Provider.of<MyAuthProvider>(context,listen: false).authLogOut();
                              },
                              child: Text('Sure')
                          )
                        ],
                      );
                      
                    }
                );
              },
              icon: Icon(Icons.login_outlined,size: 30,)
          ),
          SizedBox(width: 10,)
        ],
      ),
      drawer: NavigationDrawer(
          children: [
            FlutterLogo(size: 80,),
              SizedBox(height: 50,),
              Consumer<NoteProvider>(
                  builder: (context, nameProvider, child) {
                    return ListTile(
                      title: Text(nameProvider.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                      ),
                      subtitle: Text(nameProvider.userEmail,
                        style: TextStyle(
                            color: Colors.blueGrey
                        ),
                      ),
                    );

                  }
              ),
            ListTile(
              onTap: (){
                Provider.of<MyAuthProvider>(context,listen: false).authLogOut();
              },
              title: Text('Log Out',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                ),
              ),
              leading: Icon(Icons.login_outlined,color: Colors.blueAccent,),
            )

          ]
      ),
      body: Consumer<NoteProvider>(
        builder: (context, notesProvider, child) {
          if(notesProvider.isLoading){
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blueAccent,
                  size: 50),
            );
          }
          if(notesProvider.notes.isEmpty){
            return Center(child: Text('Notes is Empty'),);
          }
          return ListView.builder(
            itemCount: notesProvider.notes.length,
            itemBuilder: (context , index){
              final note=notesProvider.notes[index];
              return Card(
                child: ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, RouteHelper.updateNote,arguments: note);
                  },
                  title: Text(
                   note.title ?? 'No title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent
                    ),
                  ),
                  subtitle: Text(
                    note.desc ?? ''
                  ),
                  leading: Icon(CupertinoIcons.book,color: Colors.lightBlueAccent,),
                  trailing: notesProvider.deleteNoteId==note.id? SizedBox(
                    height: 48,
                    width: 48,
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blueAccent,
                          size: 24),
                    ),
                  ):
                  IconButton(
                      onPressed: (){
                        notesProvider.deleteNote(note);
                      },
                      icon: Icon(CupertinoIcons.trash,color: Colors.red,)),
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.pushNamed(context, RouteHelper.addNote);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
