import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rideshare/core/errors/failures.dart';

import '../entity/passenger.dart';

abstract class PassengerRepository extends Equatable {
  Future<Either<Failure, Passenger>> updateData({String? fullNmae, int? age});
  Future<Either<Failure, Passenger>> getData();
}
