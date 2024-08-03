// home screen
// an appbar with a ttile of "角色"
// use customscrollview to make the listview scrollable and add a sliverlist
import 'package:demo_rpg/home/theme2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 100.0,
            // leading: IconButton(
            //   icon: const Icon(Icons.menu),
            //   onPressed: () {},
            // ),
            // backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '角色',
                // style: AppTheme.titleLarge(context),
              ),
              centerTitle: true,
            ),
            // actions: [
            //   IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            //   const Spacer(),
            //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            // ],
          ),
          SliverToBoxAdapter(
            child: StyledContainer(
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'body medium',
                      style: AppTheme.bodyMedium,
                    ),
                    const Text(
                      'title medium',
                      style: AppTheme.titleMedium,
                    ),
                    const Text(
                      'title medium',
                      style: AppTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your button logic here
                      },
                      child: const Text('Elevated Button'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your button logic here
                      },
                      child: const Text('Text Button'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // Add your button logic here
                      },
                      child: const Text('Outlined Button'),
                    ),
                    const TextField(),
                    const TextField(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your name',
                      ),
                    ),
                    const Card(
                      child: ListTile(
                        title: Text('Card Title'),
                        subtitle: Text('Card Subtitle'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
