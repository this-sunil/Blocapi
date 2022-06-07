import 'package:demo/Bloc/Respository/respository.dart';
import 'package:demo/Bloc/bloc/PhotoBloc.dart';
import 'package:demo/Bloc/bloc/PhotoEvent.dart';
import 'package:demo/Bloc/bloc/PhotoState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  final PhotoBloc _photoBloc =PhotoBloc();
  @override
  void initState() {

    _photoBloc.add(LoadPhotoEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test Demo"),
        ),
        body: BlocProvider(
          create: (_)=>_photoBloc,
          child: BlocBuilder<PhotoBloc, PhotoState>(
              builder: (context, state) {
               if(state is PhotoInitialState){
                 return const Center(child: CircularProgressIndicator());
               }
                else if (state is PhotoLoadedState) {
                  return ListView.builder(
                      itemCount: state.photoModel.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(state.photoModel[index].id.toString())),
                            title: Text(state.photoModel[index].title),
                            subtitle: Text(state.photoModel[index].body),
                          ),
                        );
                      });
                }
                return const Center(child: Text("Data not Found"));

              },
            ),

        ));
  }
}
