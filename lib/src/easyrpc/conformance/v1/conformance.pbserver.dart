// This is a generated file - do not edit.
//
// Generated from easyrpc/conformance/v1/conformance.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'conformance.pb.dart' as $0;
import 'conformance.pbjson.dart';

export 'conformance.pb.dart';

abstract class ConformanceServiceBase extends $pb.GeneratedService {
  $async.Future<$0.HealthResponse> health(
      $pb.ServerContext ctx, $0.HealthRequest request);
  $async.Future<$0.EchoResponse> echo(
      $pb.ServerContext ctx, $0.EchoRequest request);
  $async.Future<$0.CountResponse> count(
      $pb.ServerContext ctx, $0.CountRequest request);
  $async.Future<$0.FailResponse> fail(
      $pb.ServerContext ctx, $0.FailRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Health':
        return $0.HealthRequest();
      case 'Echo':
        return $0.EchoRequest();
      case 'Count':
        return $0.CountRequest();
      case 'Fail':
        return $0.FailRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Health':
        return health(ctx, request as $0.HealthRequest);
      case 'Echo':
        return echo(ctx, request as $0.EchoRequest);
      case 'Count':
        return count(ctx, request as $0.CountRequest);
      case 'Fail':
        return fail(ctx, request as $0.FailRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      ConformanceServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ConformanceServiceBase$messageJson;
}
