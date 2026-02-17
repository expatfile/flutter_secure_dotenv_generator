import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_secure_dotenv_generator/src/annotation_generator.dart';
import 'package:flutter_secure_dotenv_generator/src/environment_field.dart';
import 'package:flutter_secure_dotenv_generator/src/helpers.dart';
import 'package:test/test.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

void main() {
  group('FlutterSecureDotEnvAnnotationGenerator', () {
    late FlutterSecureDotEnvAnnotationGenerator generator;
    late BuilderOptions options;

    setUp(() {
      options = BuilderOptions({
        'ENCRYPTION_KEY': 'test_encryption_key',
        'IV': 'test_initialization_vector',
        'OUTPUT_FILE': 'test_output_file',
      });
      generator = FlutterSecureDotEnvAnnotationGenerator(options);
    });

    test('should throw exception if element is not a class', () async {
      final element = TopLevelFunctionElementMock('testFunction');
      final annotation = ConstantReader(null);
      final buildStep = BuildStepMock();

      expect(
        () => generator.generateForAnnotatedElement(
            element, annotation, buildStep),
        throwsException,
      );
    });
  });

  group('EnvironmentField', () {
    test('should create an instance of EnvironmentField', () {
      final field = EnvironmentField('name', 'nameOverride',
          DartTypeMock('String'), DartObjectMock('defaultValue'));

      expect(field.name, 'name');
      expect(field.nameOverride, 'nameOverride');
      expect(field.type, isA<DartType>());
      expect(field.defaultValue, isA<DartObject>());
    });
  });

  group('Helpers', () {
    test('should get all accessor names', () {
      final interface = InterfaceElementMock('TestInterface');
      final accessorNames = getAllAccessorNames(interface);

      expect(accessorNames, isNotEmpty);
    });
  });
}

// ignore: subtype_of_sealed_class
class BuildStepMock implements BuildStep {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TopLevelFunctionElementMock implements TopLevelFunctionElement {
  final String _name;

  TopLevelFunctionElementMock(this._name);

  @override
  String? get name => _name;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ClassElementMock implements ClassElement {
  final String _name;

  ClassElementMock(this._name);

  @override
  String? get name => _name;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DartTypeMock implements DartType {
  final String typeName;

  DartTypeMock(this.typeName);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DartObjectMock implements DartObject {
  final dynamic value;

  DartObjectMock(this.value);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FieldElementMock implements FieldElement {
  @override
  final String? name;
  @override
  final DartType type;

  FieldElementMock(this.name, this.type);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class InterfaceElementMock implements InterfaceElement {
  final String _name;

  InterfaceElementMock(this._name);

  @override
  String? get name => _name;

  @override
  List<InterfaceType> get allSupertypes => [];

  @override
  List<GetterElement> get getters => [
        GetterElementMock('accessor1'),
        GetterElementMock('accessor2'),
      ];

  @override
  List<SetterElement> get setters => [];

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class LibraryElementMock implements LibraryElement {
  final String _name;

  LibraryElementMock(this._name);

  @override
  String? get name => _name;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetterElementMock implements GetterElement {
  final String _name;

  GetterElementMock(this._name);

  @override
  String? get name => _name;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class SetterElementMock implements SetterElement {
  final String _name;

  SetterElementMock(this._name);

  @override
  String? get name => _name;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
