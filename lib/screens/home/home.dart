import 'package:demo_rpg/screens/create/create.dart';
import 'package:demo_rpg/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:demo_rpg/services/character_store.dart';
import 'package:demo_rpg/models/character.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo RPG'),
        centerTitle: true,
      ),
      body: Consumer<CharacterStore>(
        builder: (context, characterStore, child) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCharacterCard(
                      context, characterStore.characters[index]),
                  childCount: characterStore.characterCount,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () => _navigateToCreateScreen(context),
                    child: const Text('Create'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context, Character character) {
    return Card(
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/images/vocations/${character.vocation.image}',
          height: 110,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        title: Text(character.name),
        subtitle: Text(character.vocation.title),
        onTap: () => _navigateToProfileScreen(context, character),
      ),
    );
  }

  void _navigateToCreateScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateScreen()),
    );
  }

  void _navigateToProfileScreen(BuildContext context, Character character) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(character: character)),
    );
  }
}
