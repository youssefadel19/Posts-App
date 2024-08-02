import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String errorMessage;

  const ErrorAddDeleteUpdatePostState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object> get props => [message];
}
