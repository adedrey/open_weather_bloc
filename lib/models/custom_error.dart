// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomeError extends Equatable {
  final String errorMsg;
  CustomeError({
    this.errorMsg = '',
  });

  @override
  String toString() => 'CustomeError(errorMsg: $errorMsg)';

  @override
  List<Object> get props => [errorMsg];
}
