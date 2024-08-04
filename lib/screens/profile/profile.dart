import 'package:demo_rpg/models/character.dart';
import 'package:demo_rpg/screens/profile/stats_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo_rpg/models/skill.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.character});

  final Character character;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/images/vocations/${character.vocation.image}',
                  height: 200,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SelectableText(
                  character.slogan,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SelectableText(
                  character.vocation.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              StatsTable(
                character: character,
              ),
            ],
          ), // Add your profile content here
        ),
      ),
    );
  }
}
