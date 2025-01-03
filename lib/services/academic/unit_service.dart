import 'package:hive/hive.dart';
import '../models/academic/unit_model.dart';

class UnitService {
  final Box<Unit> _unitBox;

  UnitService(this._unitBox);

  // Create a new unit
  Future<void> addUnit(Unit unit) async {
    if (_unitBox.containsKey(unit.id)) {
      throw Exception('Unit with ID ${unit.id} already exists.');
    }
    await _unitBox.put(unit.id, unit);
  }

  // Read a unit by ID
  Unit? getUnitById(String id) {
    return _unitBox.get(id);
  }

  // Update an existing unit
  Future<void> updateUnit(Unit updatedUnit) async {
    if (!_unitBox.containsKey(updatedUnit.id)) {
      throw Exception('Unit with ID ${updatedUnit.id} does not exist.');
    }
    await _unitBox.put(updatedUnit.id, updatedUnit);
  }

  // Delete a unit
  Future<void> deleteUnit(String id) async {
    if (!_unitBox.containsKey(id)) {
      throw Exception('Unit with ID $id does not exist.');
    }
    await _unitBox.delete(id);
  }

  // Fetch all units
  List<Unit> getAllUnits() {
    return _unitBox.values.toList();
  }

  // Fetch units by program ID
  List<Unit> getUnitsByProgram(String programId) {
    return _unitBox.values.where((unit) => unit.programId == programId).toList();
  }

  // Fetch units by semester
  List<Unit> getUnitsBySemester(int semester) {
    return _unitBox.values.where((unit) => unit.semester == semester).toList();
  }

  // Fetch units by lecturer ID
  List<Unit> getUnitsByLecturer(String lecturerId) {
    return _unitBox.values.where((unit) => unit.lecturerId == lecturerId).toList();
  }

  // Validate unit before saving
  void validateUnit(Unit unit) {
    if (unit.name.isEmpty || unit.unitCode.isEmpty) {
      throw Exception('Unit name and code cannot be empty.');
    }
    if (unit.semester < 1) {
      throw Exception('Semester must be greater than 0.');
    }
  }

  // Advanced: Search units by name
  List<Unit> searchUnitsByName(String query) {
    return _unitBox.values
        .where((unit) => unit.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
