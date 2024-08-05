import 'package:demo_rpg/models/character.dart';
import 'package:demo_rpg/theme.dart';
import 'package:flutter/material.dart';

class StatsTable extends StatefulWidget {
  const StatsTable({super.key, required this.character});

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('可用點數: ${widget.character.points}',
                  style: AppTheme.textTheme.titleMedium),
              Icon(
                Icons.star,
                color:
                    widget.character.points > 0 ? Colors.yellow : Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: widget.character.statsAsListOfMap.map((stat) {
              final title = stat['title'];
              final value = stat['value'];
              return TableRow(
                children: [
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title!,
                            style: AppTheme.textTheme.bodyMedium,
                          ))),
                  TableCell(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value!,
                            style: AppTheme.textTheme.bodyMedium,
                          ))),
                  TableCell(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Perform action for the first cell
                        widget.character.increaseStat(title);
                        setState(() {});
                      },
                    ),
                  ),
                  TableCell(
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        // Perform action for the second cell
                        widget.character.decreaseStat(title);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
