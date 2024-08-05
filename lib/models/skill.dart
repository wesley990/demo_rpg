import 'package:demo_rpg/models/vocation.dart';

class Skill {
  final String id;
  final String name;
  final String image;
  final Vocation vocation;

  Skill({
    required this.id,
    required this.name,
    required this.image,
    required this.vocation,
  });
}

final List<Skill> allSkills = [
  // 戰士技能
  Skill(
    id: '1',
    name: '破甲一擊',
    image: 'assets/images/skills/armor_break.svg',
    vocation: Vocation.warrior,
  ),
  Skill(
    id: '2',
    name: '盾牆防禦',
    image: 'assets/images/skills/shield_wall.svg',
    vocation: Vocation.warrior,
  ),
  Skill(
    id: '3',
    name: '狂暴之力',
    image: 'assets/images/skills/berserker_rage.svg',
    vocation: Vocation.warrior,
  ),
  Skill(
    id: '4',
    name: '劍刃風暴',
    image: 'assets/images/skills/blade_storm.svg',
    vocation: Vocation.warrior,
  ),
  Skill(
    id: '5',
    name: '奧術飛彈',
    image: 'assets/images/skills/arcane_missiles.svg',
    vocation: Vocation.mage,
  ),
  Skill(
    id: '6',
    name: '冰霜新星',
    image: 'assets/images/skills/frost_nova.svg',
    vocation: Vocation.mage,
  ),
  Skill(
    id: '7',
    name: '時間扭曲',
    image: 'assets/images/skills/time_warp.svg',
    vocation: Vocation.mage,
  ),
  Skill(
    id: '8',
    name: '魔法屏障',
    image: 'assets/images/skills/arcane_barrier.svg',
    vocation: Vocation.mage,
  ),
  Skill(
    id: '9',
    name: '致命毒襲',
    image: 'assets/images/skills/deadly_poison.svg',
    vocation: Vocation.rogue,
  ),
  Skill(
    id: '10',
    name: '暗影步',
    image: 'assets/images/skills/shadow_step.svg',
    vocation: Vocation.rogue,
  ),
  Skill(
    id: '11',
    name: '疾速連擊',
    image: 'assets/images/skills/rapid_strike.svg',
    vocation: Vocation.rogue,
  ),
  Skill(
    id: '12',
    name: '煙霧彈',
    image: 'assets/images/skills/smoke_bomb.svg',
    vocation: Vocation.rogue,
  ),
  Skill(
    id: '13',
    name: '神聖之光',
    image: 'assets/images/skills/holy_light.svg',
    vocation: Vocation.cleric,
  ),
  Skill(
    id: '14',
    name: '治療禱言',
    image: 'assets/images/skills/healing_prayer.svg',
    vocation: Vocation.cleric,
  ),
  Skill(
    id: '15',
    name: '淨化之觸',
    image: 'assets/images/skills/purifying_touch.svg',
    vocation: Vocation.cleric,
  ),
  Skill(
    id: '16',
    name: '神聖懲戒',
    image: 'assets/images/skills/rapid_strike.svg',
    vocation: Vocation.cleric,
  ),
];
