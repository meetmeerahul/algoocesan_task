part of 'apifetch_bloc.dart';

class ApifetchState {
  final bool isLoading;
  final String? imageUrl;
  final bool hasError;

  ApifetchState(this.imageUrl,
      {required this.isLoading, required this.hasError});
}

final class ApifetchInitial extends ApifetchState {
  ApifetchInitial(super.imageUrl,
      {required super.isLoading, required super.hasError});
}

final class ApiHasError extends ApifetchState {
  ApiHasError(super.imageUrl,
      {required super.isLoading, required super.hasError});
}
