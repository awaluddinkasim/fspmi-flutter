import 'package:equatable/equatable.dart';
import 'package:fspmi/models/iuran.dart';

class IuranState extends Equatable {
  const IuranState();

  @override
  List<Object?> get props => [];
}

class IuranInitial extends IuranState {}

class IuranLoading extends IuranState {}

class IuranSuccess extends IuranState {
  final Iuran iuran;

  const IuranSuccess(this.iuran);

  @override
  List<Object?> get props => [iuran];
}

class IuranFailed extends IuranState {
  final String message;

  const IuranFailed(this.message);

  @override
  List<Object?> get props => [message];
}
