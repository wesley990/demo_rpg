import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:demo_rpg/models/skill.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillList extends StatefulWidget {
  const SkillList({super.key, required this.character});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;

  @override
  void initState() {
    super.initState();
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: availableSkills.map((skill) {
        log('Loading skill image: ${skill.image}');
        return Container(
          margin: const EdgeInsets.all(4.0),
          constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width - 50) / 4),
          child: SvgPicture.asset(
            skill.image,
            // width: 50,
          ),
        );
      }).toList(),
    );
  }
}
