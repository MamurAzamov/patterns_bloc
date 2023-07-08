import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list_post_cubit.dart';
import '../bloc/list_post_state.dart';
import '../model/post_model.dart';
import '../views/view_of_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLoC"),
      ),
      body: BlocBuilder<ListPostCubit, ListPostState>(
          builder: (BuildContext context, ListPostState state) {
        if (state is ListPostError) {
          return viewOfHome(items, false);
        }
        if (state is ListPostLoaded) {
          items = state.posts!;
          return viewOfHome(items, false);
        }
        return viewOfHome(items, true);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ListPostCubit>(context).callCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
