import 'Indexes.dart';

class Module {
  final String code;
  final String name;
  final String description;
  final int au;

  final List<Index> indexes;

  Module(this.code, this.name, this.description, this.au, this.indexes);
}
