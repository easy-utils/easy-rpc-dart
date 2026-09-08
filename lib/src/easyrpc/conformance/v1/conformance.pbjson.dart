// This is a generated file - do not edit.
//
// Generated from easyrpc/conformance/v1/conformance.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use echoRequestDescriptor instead')
const EchoRequest$json = {
  '1': 'EchoRequest',
  '2': [
    {'1': 'input', '3': 1, '4': 1, '5': 9, '10': 'input'},
  ],
};

/// Descriptor for `EchoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoRequestDescriptor =
    $convert.base64Decode('CgtFY2hvUmVxdWVzdBIUCgVpbnB1dBgBIAEoCVIFaW5wdXQ=');

@$core.Deprecated('Use echoResponseDescriptor instead')
const EchoResponse$json = {
  '1': 'EchoResponse',
  '2': [
    {'1': 'output', '3': 1, '4': 1, '5': 9, '10': 'output'},
  ],
};

/// Descriptor for `EchoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoResponseDescriptor = $convert
    .base64Decode('CgxFY2hvUmVzcG9uc2USFgoGb3V0cHV0GAEgASgJUgZvdXRwdXQ=');

@$core.Deprecated('Use countRequestDescriptor instead')
const CountRequest$json = {
  '1': 'CountRequest',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
  ],
};

/// Descriptor for `CountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countRequestDescriptor =
    $convert.base64Decode('CgxDb3VudFJlcXVlc3QSFAoFY291bnQYASABKAVSBWNvdW50');

@$core.Deprecated('Use countResponseDescriptor instead')
const CountResponse$json = {
  '1': 'CountResponse',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `CountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countResponseDescriptor = $convert
    .base64Decode('Cg1Db3VudFJlc3BvbnNlEhQKBWluZGV4GAEgASgFUgVpbmRleA==');

@$core.Deprecated('Use failRequestDescriptor instead')
const FailRequest$json = {
  '1': 'FailRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `FailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failRequestDescriptor = $convert
    .base64Decode('CgtGYWlsUmVxdWVzdBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use failResponseDescriptor instead')
const FailResponse$json = {
  '1': 'FailResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `FailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failResponseDescriptor =
    $convert.base64Decode('CgxGYWlsUmVzcG9uc2USDgoCb2sYASABKAhSAm9r');

@$core.Deprecated('Use healthRequestDescriptor instead')
const HealthRequest$json = {
  '1': 'HealthRequest',
};

/// Descriptor for `HealthRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthRequestDescriptor =
    $convert.base64Decode('Cg1IZWFsdGhSZXF1ZXN0');

@$core.Deprecated('Use healthResponseDescriptor instead')
const HealthResponse$json = {
  '1': 'HealthResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HealthResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthResponseDescriptor = $convert.base64Decode(
    'Cg5IZWFsdGhSZXNwb25zZRIOCgJvaxgBIAEoCFICb2sSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');

const $core.Map<$core.String, $core.dynamic> ConformanceServiceBase$json = {
  '1': 'ConformanceService',
  '2': [
    {
      '1': 'Health',
      '2': '.easyrpc.conformance.v1.HealthRequest',
      '3': '.easyrpc.conformance.v1.HealthResponse',
      '4': {}
    },
    {
      '1': 'Echo',
      '2': '.easyrpc.conformance.v1.EchoRequest',
      '3': '.easyrpc.conformance.v1.EchoResponse',
      '4': {}
    },
    {
      '1': 'Count',
      '2': '.easyrpc.conformance.v1.CountRequest',
      '3': '.easyrpc.conformance.v1.CountResponse',
      '4': {},
      '6': true
    },
    {
      '1': 'Fail',
      '2': '.easyrpc.conformance.v1.FailRequest',
      '3': '.easyrpc.conformance.v1.FailResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use conformanceServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ConformanceServiceBase$messageJson = {
  '.easyrpc.conformance.v1.HealthRequest': HealthRequest$json,
  '.easyrpc.conformance.v1.HealthResponse': HealthResponse$json,
  '.easyrpc.conformance.v1.EchoRequest': EchoRequest$json,
  '.easyrpc.conformance.v1.EchoResponse': EchoResponse$json,
  '.easyrpc.conformance.v1.CountRequest': CountRequest$json,
  '.easyrpc.conformance.v1.CountResponse': CountResponse$json,
  '.easyrpc.conformance.v1.FailRequest': FailRequest$json,
  '.easyrpc.conformance.v1.FailResponse': FailResponse$json,
};

/// Descriptor for `ConformanceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List conformanceServiceDescriptor = $convert.base64Decode(
    'ChJDb25mb3JtYW5jZVNlcnZpY2USawoGSGVhbHRoEiUuZWFzeXJwYy5jb25mb3JtYW5jZS52MS'
    '5IZWFsdGhSZXF1ZXN0GiYuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5IZWFsdGhSZXNwb25zZSIS'
    'gtPkkwIMEgovdjEvaGVhbHRoEmYKBEVjaG8SIy5lYXN5cnBjLmNvbmZvcm1hbmNlLnYxLkVjaG'
    '9SZXF1ZXN0GiQuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5FY2hvUmVzcG9uc2UiE4LT5JMCDToB'
    'KiIIL3YxL2VjaG8SbAoFQ291bnQSJC5lYXN5cnBjLmNvbmZvcm1hbmNlLnYxLkNvdW50UmVxdW'
    'VzdBolLmVhc3lycGMuY29uZm9ybWFuY2UudjEuQ291bnRSZXNwb25zZSIUgtPkkwIOOgEqIgkv'
    'djEvY291bnQwARJmCgRGYWlsEiMuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5GYWlsUmVxdWVzdB'
    'okLmVhc3lycGMuY29uZm9ybWFuY2UudjEuRmFpbFJlc3BvbnNlIhOC0+STAg06ASoiCC92MS9m'
    'YWls');
