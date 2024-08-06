import 'package:flutter/material.dart';
import 'package:demo_rpg/models/skill.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillList extends StatelessWidget {
  const SkillList({
    super.key,
    required this.character,
    required this.onSkillChanged,
  });

  final Character character;
  final VoidCallback onSkillChanged;

  @override
  Widget build(BuildContext context) {
    return _SkillListContent(
      character: character,
      onSkillChanged: onSkillChanged,
    );
  }
}

class _SkillListContent extends StatefulWidget {
  const _SkillListContent({
    required this.character,
    required this.onSkillChanged,
  });

  final Character character;
  final VoidCallback onSkillChanged;

  @override
  State<_SkillListContent> createState() => _SkillListContentState();
}

class _SkillListContentState extends State<_SkillListContent> {
  late final List<Skill> _availableSkills;
  late Skill _selectedSkill;

  @override
  void initState() {
    super.initState();
    _availableSkills = allSkills
        .where((skill) => skill.vocation == widget.character.vocation)
        .toList();
    _selectedSkill = widget.character.skills.isEmpty
        ? _availableSkills.first
        : widget.character.skills.first;
  }

  void _onSkillTap(Skill skill) {
    setState(() {
      _selectedSkill = skill;
      widget.character.updateSkill(skill);
      widget.onSkillChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 50) / 4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final skill in _availableSkills)
              _SkillItem(
                skill: skill,
                isSelected: skill == _selectedSkill,
                onTap: () => _onSkillTap(skill),
                width: itemWidth,
              ),
          ],
        );
      },
    );
  }
}

class _SkillItem extends StatelessWidget {
  const _SkillItem({
    required this.skill,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  final Skill skill;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.blue : Colors.transparent,
        constraints: BoxConstraints(maxWidth: width),
        child: SvgPicture.asset(
          skill.image,
          semanticsLabel: skill.name,
        ),
      ),
    );
  }
}

// This updated version incorporates several modern Dart and Flutter best practices:

// Separation of concerns: The stateless SkillList widget now delegates to a private stateful _SkillListContent widget. This follows the principle of composing widgets for better maintainability.
// Use of const constructors: Wherever possible, constructors are marked as const to improve performance.
// Null safety: The code assumes you're using a recent version of Dart with null safety enabled.
// Late initialization: The late keyword is used for variables that will be initialized after the constructor but before they're used.
// For-in loops in widget lists: Instead of using .map(), we use a more readable for-in loop within the list literal.
// LayoutBuilder: This widget is used to make the layout more responsive to different screen sizes.
// Extraction of widget: The _SkillItem widget has been extracted to its own class for better reusability and readability.
// Use of private classes: Underscore prefix is used for classes that should not be used outside of this file.
// Avoiding abbreviations: Variable names are more descriptive (e.g., onSkillTap instead of just onTap).
// Semantic labels: Added a semanticsLabel to the SvgPicture for better accessibility.