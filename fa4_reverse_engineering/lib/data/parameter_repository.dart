import 'package:fa4_reverse_engineering/models/parameter.dart';

class ParameterRepository {
  static final List<Parameter> parameters = [];

  static void add(Parameter parameter) {
    parameters.add(parameter);
  }
}