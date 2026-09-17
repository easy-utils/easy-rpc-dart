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
    final result = EchoRequest._();
    if (input != null) result.input = input;
    return result;
  }

  EchoRequest._();

  factory EchoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoRequest()..mergeFromBuffer(data, registry);
  factory EchoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: EchoRequest.$_createMessage)
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
  @$core.Deprecated('Use EchoRequest() / EchoRequest.new instead')
  static EchoRequest create() => EchoRequest._();
  static $pb.GeneratedMessage $_createMessage() => EchoRequest._();
  @$core.override
  EchoRequest createEmptyInstance() => EchoRequest._();
  @$core.pragma('dart2js:noInline')
  static EchoRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoRequest>(
          EchoRequest.$_createMessage);
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
    final result = EchoResponse._();
    if (output != null) result.output = output;
    return result;
  }

  EchoResponse._();

  factory EchoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoResponse()..mergeFromBuffer(data, registry);
  factory EchoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: EchoResponse.$_createMessage)
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
  @$core.Deprecated('Use EchoResponse() / EchoResponse.new instead')
  static EchoResponse create() => EchoResponse._();
  static $pb.GeneratedMessage $_createMessage() => EchoResponse._();
  @$core.override
  EchoResponse createEmptyInstance() => EchoResponse._();
  @$core.pragma('dart2js:noInline')
  static EchoResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoResponse>(
          EchoResponse.$_createMessage);
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
    final result = CountRequest._();
    if (count != null) result.count = count;
    return result;
  }

  CountRequest._();

  factory CountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountRequest()..mergeFromBuffer(data, registry);
  factory CountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: CountRequest.$_createMessage)
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
  @$core.Deprecated('Use CountRequest() / CountRequest.new instead')
  static CountRequest create() => CountRequest._();
  static $pb.GeneratedMessage $_createMessage() => CountRequest._();
  @$core.override
  CountRequest createEmptyInstance() => CountRequest._();
  @$core.pragma('dart2js:noInline')
  static CountRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountRequest>(
          CountRequest.$_createMessage);
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
    final result = CountResponse._();
    if (index != null) result.index = index;
    return result;
  }

  CountResponse._();

  factory CountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountResponse()..mergeFromBuffer(data, registry);
  factory CountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CountResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: CountResponse.$_createMessage)
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
  @$core.Deprecated('Use CountResponse() / CountResponse.new instead')
  static CountResponse create() => CountResponse._();
  static $pb.GeneratedMessage $_createMessage() => CountResponse._();
  @$core.override
  CountResponse createEmptyInstance() => CountResponse._();
  @$core.pragma('dart2js:noInline')
  static CountResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CountResponse>(
          CountResponse.$_createMessage);
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
    final result = FailRequest._();
    if (message != null) result.message = message;
    return result;
  }

  FailRequest._();

  factory FailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailRequest()..mergeFromBuffer(data, registry);
  factory FailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: FailRequest.$_createMessage)
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
  @$core.Deprecated('Use FailRequest() / FailRequest.new instead')
  static FailRequest create() => FailRequest._();
  static $pb.GeneratedMessage $_createMessage() => FailRequest._();
  @$core.override
  FailRequest createEmptyInstance() => FailRequest._();
  @$core.pragma('dart2js:noInline')
  static FailRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FailRequest>(
          FailRequest.$_createMessage);
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
    final result = FailResponse._();
    if (ok != null) result.ok = ok;
    return result;
  }

  FailResponse._();

  factory FailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailResponse()..mergeFromBuffer(data, registry);
  factory FailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: FailResponse.$_createMessage)
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
  @$core.Deprecated('Use FailResponse() / FailResponse.new instead')
  static FailResponse create() => FailResponse._();
  static $pb.GeneratedMessage $_createMessage() => FailResponse._();
  @$core.override
  FailResponse createEmptyInstance() => FailResponse._();
  @$core.pragma('dart2js:noInline')
  static FailResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FailResponse>(
          FailResponse.$_createMessage);
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
  factory HealthRequest() => HealthRequest._();

  HealthRequest._();

  factory HealthRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HealthRequest()..mergeFromBuffer(data, registry);
  factory HealthRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HealthRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: HealthRequest.$_createMessage)
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
  @$core.Deprecated('Use HealthRequest() / HealthRequest.new instead')
  static HealthRequest create() => HealthRequest._();
  static $pb.GeneratedMessage $_createMessage() => HealthRequest._();
  @$core.override
  HealthRequest createEmptyInstance() => HealthRequest._();
  @$core.pragma('dart2js:noInline')
  static HealthRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthRequest>(
          HealthRequest.$_createMessage);
  static HealthRequest? _defaultInstance;
}

class HealthResponse extends $pb.GeneratedMessage {
  factory HealthResponse({
    $core.bool? ok,
    $core.String? name,
  }) {
    final result = HealthResponse._();
    if (ok != null) result.ok = ok;
    if (name != null) result.name = name;
    return result;
  }

  HealthResponse._();

  factory HealthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HealthResponse()..mergeFromBuffer(data, registry);
  factory HealthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HealthResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: HealthResponse.$_createMessage)
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
  @$core.Deprecated('Use HealthResponse() / HealthResponse.new instead')
  static HealthResponse create() => HealthResponse._();
  static $pb.GeneratedMessage $_createMessage() => HealthResponse._();
  @$core.override
  HealthResponse createEmptyInstance() => HealthResponse._();
  @$core.pragma('dart2js:noInline')
  static HealthResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthResponse>(
          HealthResponse.$_createMessage);
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

class StreamFailRequest extends $pb.GeneratedMessage {
  factory StreamFailRequest({
    $core.int? emitBefore,
    $core.int? code,
    $core.String? message,
  }) {
    final result = StreamFailRequest._();
    if (emitBefore != null) result.emitBefore = emitBefore;
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    return result;
  }

  StreamFailRequest._();

  factory StreamFailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailRequest()..mergeFromBuffer(data, registry);
  factory StreamFailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamFailRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: StreamFailRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'emitBefore')
    ..aI(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailRequest copyWith(void Function(StreamFailRequest) updates) =>
      super.copyWith((message) => updates(message as StreamFailRequest))
          as StreamFailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StreamFailRequest() / StreamFailRequest.new instead')
  static StreamFailRequest create() => StreamFailRequest._();
  static $pb.GeneratedMessage $_createMessage() => StreamFailRequest._();
  @$core.override
  StreamFailRequest createEmptyInstance() => StreamFailRequest._();
  @$core.pragma('dart2js:noInline')
  static StreamFailRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamFailRequest>(
          StreamFailRequest.$_createMessage);
  static StreamFailRequest? _defaultInstance;

  /// Emit this many data frames, then fail with `code`.
  @$pb.TagNumber(1)
  $core.int get emitBefore => $_getIZ(0);
  @$pb.TagNumber(1)
  set emitBefore($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmitBefore() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmitBefore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get code => $_getIZ(1);
  @$pb.TagNumber(2)
  set code($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

class StreamFailResponse extends $pb.GeneratedMessage {
  factory StreamFailResponse({
    $core.int? index,
  }) {
    final result = StreamFailResponse._();
    if (index != null) result.index = index;
    return result;
  }

  StreamFailResponse._();

  factory StreamFailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailResponse()..mergeFromBuffer(data, registry);
  factory StreamFailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamFailResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: StreamFailResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailResponse copyWith(void Function(StreamFailResponse) updates) =>
      super.copyWith((message) => updates(message as StreamFailResponse))
          as StreamFailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use StreamFailResponse() / StreamFailResponse.new instead')
  static StreamFailResponse create() => StreamFailResponse._();
  static $pb.GeneratedMessage $_createMessage() => StreamFailResponse._();
  @$core.override
  StreamFailResponse createEmptyInstance() => StreamFailResponse._();
  @$core.pragma('dart2js:noInline')
  static StreamFailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamFailResponse>(
          StreamFailResponse.$_createMessage);
  static StreamFailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);
}

class EchoMetaRequest extends $pb.GeneratedMessage {
  factory EchoMetaRequest({
    $core.String? input,
  }) {
    final result = EchoMetaRequest._();
    if (input != null) result.input = input;
    return result;
  }

  EchoMetaRequest._();

  factory EchoMetaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoMetaRequest()..mergeFromBuffer(data, registry);
  factory EchoMetaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoMetaRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoMetaRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: EchoMetaRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'input')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoMetaRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoMetaRequest copyWith(void Function(EchoMetaRequest) updates) =>
      super.copyWith((message) => updates(message as EchoMetaRequest))
          as EchoMetaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EchoMetaRequest() / EchoMetaRequest.new instead')
  static EchoMetaRequest create() => EchoMetaRequest._();
  static $pb.GeneratedMessage $_createMessage() => EchoMetaRequest._();
  @$core.override
  EchoMetaRequest createEmptyInstance() => EchoMetaRequest._();
  @$core.pragma('dart2js:noInline')
  static EchoMetaRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoMetaRequest>(
          EchoMetaRequest.$_createMessage);
  static EchoMetaRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get input => $_getSZ(0);
  @$pb.TagNumber(1)
  set input($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInput() => $_has(0);
  @$pb.TagNumber(1)
  void clearInput() => $_clearField(1);
}

class EchoMetaResponse extends $pb.GeneratedMessage {
  factory EchoMetaResponse({
    $core.String? input,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? meta,
  }) {
    final result = EchoMetaResponse._();
    if (input != null) result.input = input;
    if (meta != null) result.meta.addEntries(meta);
    return result;
  }

  EchoMetaResponse._();

  factory EchoMetaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoMetaResponse()..mergeFromBuffer(data, registry);
  factory EchoMetaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EchoMetaResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EchoMetaResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: EchoMetaResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'input')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'meta',
        entryClassName: 'EchoMetaResponse.MetaEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('easyrpc.conformance.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoMetaResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EchoMetaResponse copyWith(void Function(EchoMetaResponse) updates) =>
      super.copyWith((message) => updates(message as EchoMetaResponse))
          as EchoMetaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EchoMetaResponse() / EchoMetaResponse.new instead')
  static EchoMetaResponse create() => EchoMetaResponse._();
  static $pb.GeneratedMessage $_createMessage() => EchoMetaResponse._();
  @$core.override
  EchoMetaResponse createEmptyInstance() => EchoMetaResponse._();
  @$core.pragma('dart2js:noInline')
  static EchoMetaResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EchoMetaResponse>(
          EchoMetaResponse.$_createMessage);
  static EchoMetaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get input => $_getSZ(0);
  @$pb.TagNumber(1)
  set input($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInput() => $_has(0);
  @$pb.TagNumber(1)
  void clearInput() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get meta => $_getMap(1);
}

class BigRequest extends $pb.GeneratedMessage {
  factory BigRequest({
    $core.int? size,
  }) {
    final result = BigRequest._();
    if (size != null) result.size = size;
    return result;
  }

  BigRequest._();

  factory BigRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BigRequest()..mergeFromBuffer(data, registry);
  factory BigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BigRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BigRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: BigRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BigRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BigRequest copyWith(void Function(BigRequest) updates) =>
      super.copyWith((message) => updates(message as BigRequest)) as BigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BigRequest() / BigRequest.new instead')
  static BigRequest create() => BigRequest._();
  static $pb.GeneratedMessage $_createMessage() => BigRequest._();
  @$core.override
  BigRequest createEmptyInstance() => BigRequest._();
  @$core.pragma('dart2js:noInline')
  static BigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BigRequest>(BigRequest.$_createMessage);
  static BigRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get size => $_getIZ(0);
  @$pb.TagNumber(1)
  set size($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => $_clearField(1);
}

class BigResponse extends $pb.GeneratedMessage {
  factory BigResponse({
    $core.int? size,
  }) {
    final result = BigResponse._();
    if (size != null) result.size = size;
    return result;
  }

  BigResponse._();

  factory BigResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BigResponse()..mergeFromBuffer(data, registry);
  factory BigResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BigResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BigResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: BigResponse.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BigResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BigResponse copyWith(void Function(BigResponse) updates) =>
      super.copyWith((message) => updates(message as BigResponse))
          as BigResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BigResponse() / BigResponse.new instead')
  static BigResponse create() => BigResponse._();
  static $pb.GeneratedMessage $_createMessage() => BigResponse._();
  @$core.override
  BigResponse createEmptyInstance() => BigResponse._();
  @$core.pragma('dart2js:noInline')
  static BigResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BigResponse>(
          BigResponse.$_createMessage);
  static BigResponse? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get size => $_getIZ(0);
  @$pb.TagNumber(2)
  set size($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);
}

class FailDetailsRequest extends $pb.GeneratedMessage {
  factory FailDetailsRequest({
    $core.int? code,
    $core.String? message,
    $core.String? detailType,
    $core.String? detailText,
  }) {
    final result = FailDetailsRequest._();
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    if (detailType != null) result.detailType = detailType;
    if (detailText != null) result.detailText = detailText;
    return result;
  }

  FailDetailsRequest._();

  factory FailDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailDetailsRequest()..mergeFromBuffer(data, registry);
  factory FailDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailDetailsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: FailDetailsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'detailType')
    ..aOS(4, _omitFieldNames ? '' : 'detailText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailDetailsRequest copyWith(void Function(FailDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as FailDetailsRequest))
          as FailDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FailDetailsRequest() / FailDetailsRequest.new instead')
  static FailDetailsRequest create() => FailDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() => FailDetailsRequest._();
  @$core.override
  FailDetailsRequest createEmptyInstance() => FailDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static FailDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FailDetailsRequest>(
          FailDetailsRequest.$_createMessage);
  static FailDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get detailType => $_getSZ(2);
  @$pb.TagNumber(3)
  set detailType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDetailType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDetailType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get detailText => $_getSZ(3);
  @$pb.TagNumber(4)
  set detailText($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDetailText() => $_has(3);
  @$pb.TagNumber(4)
  void clearDetailText() => $_clearField(4);
}

class FailDetailsResponse extends $pb.GeneratedMessage {
  factory FailDetailsResponse({
    $core.bool? ok,
  }) {
    final result = FailDetailsResponse._();
    if (ok != null) result.ok = ok;
    return result;
  }

  FailDetailsResponse._();

  factory FailDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailDetailsResponse()..mergeFromBuffer(data, registry);
  factory FailDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FailDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FailDetailsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: FailDetailsResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FailDetailsResponse copyWith(void Function(FailDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as FailDetailsResponse))
          as FailDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use FailDetailsResponse() / FailDetailsResponse.new instead')
  static FailDetailsResponse create() => FailDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() => FailDetailsResponse._();
  @$core.override
  FailDetailsResponse createEmptyInstance() => FailDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static FailDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FailDetailsResponse>(
          FailDetailsResponse.$_createMessage);
  static FailDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => $_clearField(1);
}

class StreamFailDetailsRequest extends $pb.GeneratedMessage {
  factory StreamFailDetailsRequest({
    $core.int? emitBefore,
    $core.int? code,
    $core.String? message,
    $core.String? detailType,
    $core.String? detailText,
  }) {
    final result = StreamFailDetailsRequest._();
    if (emitBefore != null) result.emitBefore = emitBefore;
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    if (detailType != null) result.detailType = detailType;
    if (detailText != null) result.detailText = detailText;
    return result;
  }

  StreamFailDetailsRequest._();

  factory StreamFailDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailDetailsRequest()..mergeFromBuffer(data, registry);
  factory StreamFailDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailDetailsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamFailDetailsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: StreamFailDetailsRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'emitBefore')
    ..aI(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'detailType')
    ..aOS(5, _omitFieldNames ? '' : 'detailText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailDetailsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailDetailsRequest copyWith(
          void Function(StreamFailDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as StreamFailDetailsRequest))
          as StreamFailDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use StreamFailDetailsRequest() / StreamFailDetailsRequest.new instead')
  static StreamFailDetailsRequest create() => StreamFailDetailsRequest._();
  static $pb.GeneratedMessage $_createMessage() => StreamFailDetailsRequest._();
  @$core.override
  StreamFailDetailsRequest createEmptyInstance() =>
      StreamFailDetailsRequest._();
  @$core.pragma('dart2js:noInline')
  static StreamFailDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamFailDetailsRequest>(
          StreamFailDetailsRequest.$_createMessage);
  static StreamFailDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get emitBefore => $_getIZ(0);
  @$pb.TagNumber(1)
  set emitBefore($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmitBefore() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmitBefore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get code => $_getIZ(1);
  @$pb.TagNumber(2)
  set code($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get detailType => $_getSZ(3);
  @$pb.TagNumber(4)
  set detailType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDetailType() => $_has(3);
  @$pb.TagNumber(4)
  void clearDetailType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get detailText => $_getSZ(4);
  @$pb.TagNumber(5)
  set detailText($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDetailText() => $_has(4);
  @$pb.TagNumber(5)
  void clearDetailText() => $_clearField(5);
}

class StreamFailDetailsResponse extends $pb.GeneratedMessage {
  factory StreamFailDetailsResponse({
    $core.int? index,
  }) {
    final result = StreamFailDetailsResponse._();
    if (index != null) result.index = index;
    return result;
  }

  StreamFailDetailsResponse._();

  factory StreamFailDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailDetailsResponse()..mergeFromBuffer(data, registry);
  factory StreamFailDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      StreamFailDetailsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StreamFailDetailsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'easyrpc.conformance.v1'),
      createEmptyInstance: StreamFailDetailsResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'index')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailDetailsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamFailDetailsResponse copyWith(
          void Function(StreamFailDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as StreamFailDetailsResponse))
          as StreamFailDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use StreamFailDetailsResponse() / StreamFailDetailsResponse.new instead')
  static StreamFailDetailsResponse create() => StreamFailDetailsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      StreamFailDetailsResponse._();
  @$core.override
  StreamFailDetailsResponse createEmptyInstance() =>
      StreamFailDetailsResponse._();
  @$core.pragma('dart2js:noInline')
  static StreamFailDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StreamFailDetailsResponse>(
          StreamFailDetailsResponse.$_createMessage);
  static StreamFailDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);
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

  /// Emit N frames then end the stream with a Connect end-stream error.
  $async.Future<StreamFailResponse> streamFail(
          $pb.ClientContext? ctx, StreamFailRequest request) =>
      _client.invoke<StreamFailResponse>(ctx, 'ConformanceService',
          'StreamFail', request, StreamFailResponse());

  /// Echo selected request metadata back in the response.
  $async.Future<EchoMetaResponse> echoMeta(
          $pb.ClientContext? ctx, EchoMetaRequest request) =>
      _client.invoke<EchoMetaResponse>(
          ctx, 'ConformanceService', 'EchoMeta', request, EchoMetaResponse());

  /// Return `size` bytes to exercise max-message behavior.
  $async.Future<BigResponse> big($pb.ClientContext? ctx, BigRequest request) =>
      _client.invoke<BigResponse>(
          ctx, 'ConformanceService', 'Big', request, BigResponse());

  /// Fail the unary call with an error carrying structured details.
  $async.Future<FailDetailsResponse> failDetails(
          $pb.ClientContext? ctx, FailDetailsRequest request) =>
      _client.invoke<FailDetailsResponse>(ctx, 'ConformanceService',
          'FailDetails', request, FailDetailsResponse());

  /// Emit N frames, then fail the stream with an error carrying details.
  $async.Future<StreamFailDetailsResponse> streamFailDetails(
          $pb.ClientContext? ctx, StreamFailDetailsRequest request) =>
      _client.invoke<StreamFailDetailsResponse>(ctx, 'ConformanceService',
          'StreamFailDetails', request, StreamFailDetailsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
