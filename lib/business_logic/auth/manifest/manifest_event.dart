part of 'manifest_bloc.dart';

@immutable
abstract class ManifestEvent {

  ManifestEvent();

  @override
  List<Object?> get props => [];

}

class Manifest extends ManifestEvent {
  final int routeId;
  final String date;
  final int routeViaCityId;

  Manifest(this.routeId, this.date,this.routeViaCityId);
}

