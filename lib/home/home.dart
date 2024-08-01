// home screen
// an appbar with a ttile of "角色"
// use customscrollview to make the listview scrollable and add a sliverlist
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                '角色',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              background: Image.network(
                'https://picsum.photos/id/46/300/500',
                fit: BoxFit.cover,
              ),
            ),
            // actions: [
            //   IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            //   const Spacer(),
            //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            // ],
          ),
          const SliverToBoxAdapter(
            child: Text('TEST'),
          ),
        ],
      ),
    );
  }
}
