import 'package:dartz/dartz.dart';

extension EitherAs<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}
