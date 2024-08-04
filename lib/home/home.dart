import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this line to import the package

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
                    width: 80,
                    height: 80,
                  ),
                  title: Text(character.name),
                  subtitle: Text(character.slogan),
                ),
              );
            },
            childCount: characters.length,
          ),
        ),
      ],
    );
  }
}
