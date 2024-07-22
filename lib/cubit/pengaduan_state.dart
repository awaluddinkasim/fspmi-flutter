import 'package:equatable/equatable.dart';
import 'package:fspmi/models/pengaduan.dart';

class PengaduanState extends Equatable {
  const PengaduanState();

  @override
  List<Object> get props => [];
}

class PengaduanInitial extends PengaduanState {}

class PengaduanLoading extends PengaduanState {}

class PengaduanSuccess extends PengaduanState {
  final List<Pengaduan> pengaduan;

  const PengaduanSuccess(this.pengaduan);

  @override
  List<Object> get props => [pengaduan];
}

class PengaduanFailed extends PengaduanState {
  final String message;

  const PengaduanFailed(this.message);

  @override
  List<Object> get props => [message];
}
