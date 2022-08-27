import 'dart:collection';

import 'package:equatable/equatable.dart';

void main() {
  var z = {
    2: [2]
  };
  var a = Man(
      map: LinkedHashMap<int, List<int>>(
          equals: (p0, p1) => p0 == p1, hashCode: (e) => 1)
        ..addAll(z));
  var b = Man(
      map: LinkedHashMap()
        ..addAll({
          2: [3]
        }));

  var c = Man(
      map: LinkedHashMap(equals: (p0, p1) => p0 == p1, hashCode: (e) => 1)
        ..addAll({
          2: [2]
        }));
  var d = LinkedHashMap<int, List<int>>(
      equals: (p0, p1) => p0 == p1, hashCode: (e) => e+32);

  d.addAll(z);
  var t = Man(map: d);
  print(t == a);
  print(a.map);
  print(a.hashCode);
  print(t.hashCode);
  print(t.map);
}

class Man extends Equatable {
  final LinkedHashMap<int, List<int>> map;
  const Man({required this.map});

  @override
  // TODO: implement props
  List<Object?> get props => [map];
}
