import 'package:hive/hive.dart';
import '../models/academic/program_model.dart';
import '../models/academic/unit_model.dart';

class ProgramService {
  final Box<Program> _programBox;
  final Box<Unit> _unitBox; // Added to support fetching units linked to programs.

  ProgramService(this._programBox, this._unitBox);

  // Create a new program
  Future<void> addProgram(Program program) async {
    if (_programBox.containsKey(program.id)) {
      throw Exception('Program with ID ${program.id} already exists.');
    }
    await _programBox.put(program.id, program);
  }

  // Read a program by ID
  Program? getProgramById(String id) {
    return _programBox.get(id);
  }

  // Update an existing program
  Future<void> updateProgram(Program updatedProgram) async {
    if (!_programBox.containsKey(updatedProgram.id)) {
      throw Exception('Program with ID ${updatedProgram.id} does not exist.');
    }
    await _programBox.put(updatedProgram.id, updatedProgram);
  }

  // Delete a program
  Future<void> deleteProgram(String id) async {
    if (!_programBox.containsKey(id)) {
      throw Exception('Program with ID $id does not exist.');
    }
    await _programBox.delete(id);
  }

  // Fetch all programs
  List<Program> getAllPrograms() {
    return _programBox.values.toList();
  }

  // Fetch all programs by name filter
  List<Program> searchProgramsByName(String query) {
    return _programBox.values
        .where((program) => program.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Validate program before saving
  void validateProgram(Program program) {
    if (program.name.isEmpty || program.programCode.isEmpty) {
      throw Exception('Program name and code cannot be empty.');
    }
  }

  // Link a unit to a program
  Future<void> linkUnitToProgram(String programId, String unitId) async {
    final program = getProgramById(programId);
    if (program == null) {
      throw Exception('Program with ID $programId does not exist.');
    }
    if (program.unitIds.contains(unitId)) {
      throw Exception('Unit ID $unitId is already linked to program $programId.');
    }
    final updatedProgram = Program(
      id: program.id,
      name: program.name,
      programCode: program.programCode,
      unitIds: [...program.unitIds, unitId],
    );
    await updateProgram(updatedProgram);
  }

  // Fetch all programs with their linked units
  Map<String, List<Unit>> getProgramsWithUnits() {
    return _programBox.values.fold({}, (result, program) {
      result[program.id] = _unitBox.values
          .where((unit) => program.unitIds.contains(unit.id))
          .toList();
      return result;
    });
  }
}
