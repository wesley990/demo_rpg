import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:demo_rpg/models/skill.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillList extends StatefulWidget {
  const SkillList(
      {super.key, required this.character, required this.onSkillChanged});
  // required void Function(Set<Skill> newSkills) function});

  final Character character;
  final VoidCallback onSkillChanged;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;
  late Skill selectedSkill;
  // late Function(Set<Skill> newSkills) updateSkills;

  @override
  void initState() {
    super.initState();
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();
    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills.first;
    } else {
      selectedSkill = widget.character.skills.first;
    }
    // updateSkills = widget.character.updateSkills;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: availableSkills.map((skill) {
        log('Loading skill image: ${skill.image}');
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedSkill = skill;
              widget.character.updateSkills({skill});
              widget.onSkillChanged();
            });
          },
          child: Container(
            // margin: const EdgeInsets.all(4.0),
            color: skill == selectedSkill ? Colors.blue : Colors.transparent,
            constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width - 50) / 4,
            ),
            child: SvgPicture.asset(
              skill.image,
              // width: 50,
            ),
          ),
        );
      }).toList(),
    );
  }
}
