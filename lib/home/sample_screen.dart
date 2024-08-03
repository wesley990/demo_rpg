import 'package:demo_rpg/home/theme.dart';
import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 40.0,
            title: Text('角色'),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '角色',
              ),
              centerTitle: true,
            ),
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
                    const Text(
                      'Demo Widget 1',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Card(
                      child: ListTile(
                        title: Text('Card Title 1'),
                        subtitle: Text('Card Subtitle 1'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Card(
                      child: ListTile(
                        title: Text('Card Title 2'),
                        subtitle: Text('Card Subtitle 2'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Card(
                      child: ListTile(
                        title: Text('Card Title 3'),
                        subtitle: Text('Card Subtitle 3'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your button logic here
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: 0, // Set the current index
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          // Handle item tap
        },
      ),
    );
  }
}
