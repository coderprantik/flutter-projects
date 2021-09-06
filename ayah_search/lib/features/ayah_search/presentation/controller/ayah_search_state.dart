part of 'ayah_search_controller.dart';

abstract class AyahSearchState extends Equatable {
  const AyahSearchState();

  @override
  List<Object> get props => [];
}

class Empty extends AyahSearchState {}

class Loading extends AyahSearchState {}

class Loaded extends AyahSearchState {
  final Ayah ayah;

  Loaded(this.ayah);

  @override
  List<Object> get props => [ayah];
}

class Error extends AyahSearchState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
