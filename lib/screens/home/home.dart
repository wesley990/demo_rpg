import 'package:demo_rpg/screens/create/create.dart';
import 'package:demo_rpg/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo_rpg/services/character_store.dart';

import 'package:demo_rpg/models/character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          snap: true,
          stretch: true,
          pinned: false,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo RPG'),
            centerTitle: true,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Character character = characters[index];
              return Card(
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/images/vocations/${character.vocation.image}',
                    height: 110,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: Text(character.name),
                  subtitle: Text(character.vocation.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(character: character),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: characters.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateScreen()),
                );
              },
              child: const Text('Create'),
            ),
          ),
        ),
      ],
    );
  }
}
