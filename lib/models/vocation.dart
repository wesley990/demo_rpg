enum Vocation {
  warrior(
      title: '豪勇無雙的戰士',
      description:
          '威猛的近戰鬥士，精通各式武藝與重甲防禦。戰士以其過人的力量與高超的戰術智慧，在前線衝鋒陷陣，護佑同伴，摧毀敵軍。他們經年累月的嚴格訓練與堅毅不拔的意志，使其成為戰場上令人生畏的勁敵。',
      weapon: '巨劍',
      ability: '旋風斬',
      image: 'warrior.svg'),
  mage(
      title: '玄奧莫測的法師',
      description:
          '操縱宇宙奧秘力量的強大施法者。法師窮盡歲月鑽研魔法的精妙奧義，使其能夠隨心所欲地扭轉現實。儘管體魄孱弱，但他們對元素與神秘能量的掌控，使其在戰鬥與各種情境中都舉足輕重。',
      weapon: '法杖',
      ability: '熾炎火球',
      image: 'mage.svg'),
  rogue(
      title: '神出鬼沒的盜賊',
      description:
          '精通隱匿與精準打擊的靈巧特工。盜賊是潛行、開鎖和暗影突襲的大師。他們敏捷的頭腦與迅捷的身手，使其能夠輕鬆應對危險處境，堪稱出色的斥候與刺客。',
      weapon: '雙匕首',
      ability: '幻影步',
      image: 'rogue.svg'),
  cleric(
      title: '聖潔慈悲的牧師',
      description:
          '能夠療癒盟友並懲戒敵人的神聖施法者。牧師從對神祇堅定不移的信仰中汲取力量，使其能夠引導神蹟般的治療能量和神聖怒火。他們是團隊的精神支柱，在危急時刻提供道德指引和至關重要的支援。',
      weapon: '權杖',
      ability: '神聖醫療',
      image: 'cleric.svg');

  final String title;
  final String description;
  final String weapon;
  final String ability;
  final String image;

  const Vocation({
    required this.title,
    required this.description,
    required this.weapon,
    required this.ability,
    required this.image,
  });
}
