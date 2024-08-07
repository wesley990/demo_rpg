import 'package:flutter/material.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:demo_rpg/theme.dart';

class StatsTable extends StatelessWidget {
  const StatsTable({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) =>
      _StatsTableContent(character: character);
}

class _StatsTableContent extends StatefulWidget {
  const _StatsTableContent({required this.character});

  final Character character;

  @override
  State<_StatsTableContent> createState() => _StatsTableContentState();
}

class _StatsTableContentState extends State<_StatsTableContent> {
  void _updateStat(String title, bool increase) {
    setState(() {
      if (increase) {
        widget.character.increaseStat(title);
        turns += 0.5;
      } else {
        widget.character.decreaseStat(title);
        turns -= 0.5;
      }
    });
  }

  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _buildPointsRow(),
          const SizedBox(height: 10),
          _buildStatsTable(),
        ],
      ),
    );
  }

  Widget _buildPointsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '可用點數: ${widget.character.points}',
          style: AppTheme.textTheme.titleMedium,
        ),
        AnimatedRotation(
          duration: const Duration(milliseconds: 200),
          turns: turns,
          child: Icon(
            Icons.star,
            color: widget.character.points > 0 ? Colors.yellow : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: widget.character.statsAsListOfMap.map((stat) {
        final title = stat['title'] as String;
        final value = stat['value'] as String;
        return TableRow(
          children: [
            _buildTableCell(title),
            _buildTableCell(value),
            _buildActionButton(Icons.add, () => _updateStat(title, true)),
            _buildActionButton(Icons.remove, () => _updateStat(title, false)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: AppTheme.textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return TableCell(
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}

// Extension methods for Character class
extension CharacterStats on Character {
  void increaseStat(String statName) {
    // Implementation for increasing a stat
  }

  void decreaseStat(String statName) {
    // Implementation for decreasing a stat
  }
}


// I've made several improvements to the code:

// Separated the widget into two parts: a stateless StatsTable and a stateful _StatsTableContent. This follows the best practice of keeping the public API stable while allowing for internal state management.
// Used more descriptive method names like _buildPointsRow() and _buildStatsTable() to improve readability.
// Extracted repeated widget building into separate methods like _buildTableCell() and _buildActionButton() to reduce code duplication.
// Used modern Dart features like extension methods for Character class to add increaseStat and decreaseStat methods.
// Improved type safety by explicitly casting stat['title'] and stat['value'] to String.
// Simplified the state update logic into a single _updateStat method.
// Used const constructors where possible to improve performance.
// Removed unnecessary comments and improved existing ones.

// I've also added some useful functions that you might need:

// The _updateStat method in the state class, which handles both increasing and decreasing stats.
// Extension methods increaseStat and decreaseStat on the Character class. You'll need to implement these methods based on your specific requirements.