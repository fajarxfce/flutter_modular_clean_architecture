import 'package:dartz/dartz.dart';

abstract class NetworkBoundResource<ResultType, RequestType> {
  Stream<ResultType> result = Stream.empty();

  void onFetchFailed();
  Stream<ResultType> loadFromDB();
  bool shouldFetch(ResultType? data);
  Stream<RequestType> createCall();
  Stream<void> saveCallResult(RequestType item);
}
