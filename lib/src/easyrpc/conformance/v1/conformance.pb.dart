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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class EchoRequest extends $pb.GeneratedMessage {
  factory EchoRequest({
    $core.String? input,
  }) {
    final result = create();
    if (input != null) result.input = input;
    return result;
  }

  EchoRequest._();

  factory EchoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EchoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'input')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoRequest copyWith(void Function(EchoRequest) updates) =>
      super.copyWith((message) => updates(message as EchoRequest))
          as EchoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoRequest create() => EchoRequest._();
  @$core.override
  EchoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EchoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoRequest>(create);
  static EchoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get input => $_getSZ(0);
  @$pb.TagNumber(1)
  set input($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInput() => $_has(0);
  @$pb.TagNumber(1)
  void clearInput() => $_clearField(1);
}

class EchoResponse extends $pb.GeneratedMessage {
  factory EchoResponse({
    $core.String? output,
  }) {
    final result = create();
    if (output != null) result.output = output;
    return result;
  }

  EchoResponse._();

  factory EchoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EchoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'output')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoResponse copyWith(void Function(EchoResponse) updates) =>
      super.copyWith((message) => updates(message as EchoResponse))
          as EchoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EchoResponse create() => EchoResponse._();
  @$core.override
  EchoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EchoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EchoResponse>(create);
  static EchoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get output => $_getSZ(0);
  @$pb.TagNumber(1)
  set output($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => $_clearField(1);
}

class CountRequest extends $pb.GeneratedMessage {
  factory CountRequest({
    $core.int? count,
  }) {
    final result = create();
    if (count != null) result.count = count;
    return result;
  }

  CountRequest._();

  factory CountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountRequest copyWith(void Function(CountRequest) updates) =>
      super.copyWith((message) => updates(message as CountRequest))
          as CountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountRequest create() => CountRequest._();
  @$core.override
  CountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountRequest>(create);
  static CountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);
}

class CountResponse extends $pb.GeneratedMessage {
  factory CountResponse({
    $core.int? index,
  }) {
    final result = create();
    if (index != null) result.index = index;
    return result;
  }

  CountResponse._();

  factory CountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountResponse copyWith(void Function(CountResponse) updates) =>
      super.copyWith((message) => updates(message as CountResponse))
          as CountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountResponse create() => CountResponse._();
  @$core.override
  CountResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountResponse>(create);
  static CountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);
}

class FailRequest extends $pb.GeneratedMessage {
  factory FailRequest({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  FailRequest._();

  factory FailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailRequest copyWith(void Function(FailRequest) updates) =>
      super.copyWith((message) => updates(message as FailRequest))
          as FailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FailRequest create() => FailRequest._();
  @$core.override
  FailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FailRequest>(create);
  static FailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class FailResponse extends $pb.GeneratedMessage {
  factory FailResponse({
    $core.bool? ok,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    return result;
  }

  FailResponse._();

  factory FailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailResponse copyWith(void Function(FailResponse) updates) =>
      super.copyWith((message) => updates(message as FailResponse))
          as FailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FailResponse create() => FailResponse._();
  @$core.override
  FailResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FailResponse>(create);
  static FailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class HealthRequest extends $pb.GeneratedMessage {
  factory HealthRequest() => create();

  HealthRequest._();

  factory HealthRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthRequest copyWith(void Function(HealthRequest) updates) =>
      super.copyWith((message) => updates(message as HealthRequest))
          as HealthRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthRequest create() => HealthRequest._();
  @$core.override
  HealthRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthRequest>(create);
  static HealthRequest? _defaultInstance;
}

class HealthResponse extends $pb.GeneratedMessage {
  factory HealthResponse({
    $core.bool? ok,
    $core.String? name,
  }) {
    final result = create();
    if (ok != null) result.ok = ok;
    if (name != null) result.name = name;
    return result;
  }

  HealthResponse._();

  factory HealthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthResponse copyWith(void Function(HealthResponse) updates) =>
      super.copyWith((message) => updates(message as HealthResponse))
          as HealthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthResponse create() => HealthResponse._();
  @$core.override
  HealthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthResponse>(create);
  static HealthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class ConformanceServiceApi {
  final $pb.RpcClient _client;

  ConformanceServiceApi(this._client);

  $async.Future<HealthResponse> health(
          $pb.ClientContext? ctx, HealthRequest request) =>
      _client.invoke<HealthResponse>(
          ctx, 'ConformanceService', 'Health', request, HealthResponse());
  $async.Future<EchoResponse> echo(
          $pb.ClientContext? ctx, EchoRequest request) =>
      _client.invoke<EchoResponse>(
          ctx, 'ConformanceService', 'Echo', request, EchoResponse());
  $async.Future<CountResponse> count(
          $pb.ClientContext? ctx, CountRequest request) =>
      _client.invoke<CountResponse>(
          ctx, 'ConformanceService', 'Count', request, CountResponse());
  $async.Future<FailResponse> fail(
          $pb.ClientContext? ctx, FailRequest request) =>
      _client.invoke<FailResponse>(
          ctx, 'ConformanceService', 'Fail', request, FailResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
