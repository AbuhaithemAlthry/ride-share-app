import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rideshare/core/errors/exceptions.dart';
// import 'package:rideshare/core/errors/exception.dart';
import 'package:rideshare/core/errors/failures.dart';
import 'package:rideshare/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:rideshare/features/authentication/data/repositories/authentication_repository_impl.dart';

import 'otp_verification_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late OTPVerificationRepositoryImpl repository;
  late MockUserDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockUserDataSource();
    repository = OTPVerificationRepositoryImpl(userDataSource: mockDataSource);
  });

  group('OTPVerificationRepositoryImpl', () {
    const String phoneNumber = '+251978654567';
    const String otp = '1234';
    const bool successResult = true;

    test('should return success result when OTP verification is successful',
        () async {
      // Arrange
      when(mockDataSource.verifyOtp(phoneNumber, otp))
          .thenAnswer((_) async => successResult);

      // Act
      final Either<Failure, bool> result =
          await repository.verifyOTP(phoneNumber, otp);

      // Assert
      // ignore: always_specify_types
      expect(result, const Right(successResult));
      verify(mockDataSource.verifyOtp(phoneNumber, otp));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return failure result when OTP verification fails', () async {
      // Arrange
      when(mockDataSource.verifyOtp(phoneNumber, otp))
          .thenThrow(ServerException('Server Exception'));

      // Act
      final Either<Failure, bool> result =
          await repository.verifyOTP(phoneNumber, otp);

      // Assert
      // ignore: always_specify_types
      expect(result, const Left(ServerFailure('Server Failure')));
      verify(mockDataSource.verifyOtp(phoneNumber, otp));
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
