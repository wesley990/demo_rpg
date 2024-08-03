import 'dart:developer';

// Mixin Pattern: Allows adding this set of methods and properties to any class without inheritance
mixin Stats {
  // Encapsulation: Private map to store stats
  // Open/Closed Principle: Easy to add new stats without changing existing code
  final Map<String, int> _stats = {
    'health': 10,
    'attack': 10,
    'defense': 10,
    'skill': 10,
  };
  int _points = 10;

  // Encapsulation: Getter for points
  int get points => _points;

  // Encapsulation: Getter for stats
  Map<String, int> get statsAsMap =>
      Map.from(_stats); // Return a copy to prevent direct modification

  // Encapsulation: Getter for stats as a list of maps
  List<Map<String, String>> get statsAsListOfMap => [
        for (var entry in _stats.entries) {entry.key: entry.value.toString()}
      ];

  // Template Method Pattern: Defines the algorithm structure for changing stats
  // Single Responsibility Principle: This method is responsible only for changing a stat
  void _changeStat(String stat, bool increase) {
    stat = stat.trim().toLowerCase();
    // Defensive programming: Check for invalid input
    if (!_stats.containsKey(stat)) {
      log('Invalid stat');
      return;
    }

    // Null-safety: Use of null assertion operator (!)
    // We know the stat exists in the map due to the above check
    int currentValue = _stats[stat]!;
    if (increase && _points > 0) {
      _stats[stat] = currentValue + 1;
      _points--;
    } else if (!increase && currentValue > 5) {
      _stats[stat] = currentValue - 1;
      _points++;
    }
  }

  // Command Pattern (lightweight): These methods encapsulate all information needed to perform an action
  // DRY Principle: Reuse _changeStat logic instead of duplicating code
  void increaseStat(String stat) => _changeStat(stat, true);
  void decreaseStat(String stat) => _changeStat(stat, false);
}


// 1. Mixin Pattern:
//    The `Stats` mixin is the core design pattern here. Mixins in Dart allow for the reuse of class code in multiple class hierarchies. This pattern is useful for adding behaviors to a class without using inheritance.

// 2. Template Method Pattern:
//    While not a full implementation, the `_changeStat` method acts somewhat like a template method. It defines the skeleton of an algorithm (changing a stat) in a method, deferring some steps to the caller (whether to increase or decrease).

// 3. Command Pattern (lightweight):
//    The `increaseStat` and `decreaseStat` methods act like simple commands, encapsulating all information needed to perform an action (increasing or decreasing a stat).

// 4. Single Responsibility Principle (SOLID):
//    Each method has a single, well-defined responsibility. For example, `_changeStat` is responsible for changing a stat value, while `increaseStat` and `decreaseStat` are just wrappers that determine the direction of change.

// 5. Open/Closed Principle (SOLID):
//    The use of a Map for stats makes the mixin more open for extension (easy to add new stats) but closed for modification (core logic doesn't need to change to add stats).

// 6. DRY (Don't Repeat Yourself):
//    The refactoring significantly reduced code duplication by centralizing the stat change logic in `_changeStat`.

// I referred to our implementation as "lightweight" because it's a simplified version of the full pattern. Let me explain in more detail:



// The Command Pattern, in its full form:
// 1. Encapsulates a request as an object
// 2. Allows parameterization of clients with different requests
// 3. Allows for queueing of requests
// 4. Provides support for undoable operations

// In our "lightweight" implementation:

// 1. Encapsulation: The `increaseStat` and `decreaseStat` methods encapsulate the request to change a stat. They package the information needed to perform the action (which stat to change and in which direction).

// 2. Parameterization: Clients (other parts of the code) can use these methods with different parameters (different stats) to perform various stat changes.

// ```dart
// void increaseStat(String stat) => _changeStat(stat, true);
// void decreaseStat(String stat) => _changeStat(stat, false);
// ```

// Why it's "lightweight":
// 1. We don't create separate command classes for each operation.
// 2. We don't implement an execute() method or a common interface for commands.
// 3. We don't support more advanced features like queueing or undo operations.

// Benefits of this lightweight approach:
// 1. Simplicity: It's easy to understand and implement.
// 2. Flexibility: It's easy to add new "commands" (methods) for different stat operations.
// 3. Encapsulation: The details of how stats are changed are hidden from the client code.

// A full Command Pattern implementation might look more like this:

// ```dart
// abstract class Command {
//   void execute();
//   void undo();
// }

// class IncreaseStatCommand implements Command {
//   final Stats stats;
//   final String stat;

//   IncreaseStatCommand(this.stats, this.stat);

//   @override
//   void execute() => stats.increaseStat(stat);

//   @override
//   void undo() => stats.decreaseStat(stat);
// }

// Usage
// var command = IncreaseStatCommand(myStats, 'health');
// command.execute();
// command.undo();
// ```

// Our lightweight version captures the essence of the Command Pattern – encapsulating a request as an object – without the full complexity. This approach is often sufficient for simpler scenarios where the full power of the Command Pattern isn't necessary.
