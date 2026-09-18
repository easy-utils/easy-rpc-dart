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

@$core.Deprecated('Use streamFailRequestDescriptor instead')
const StreamFailRequest$json = {
  '1': 'StreamFailRequest',
  '2': [
    {'1': 'emit_before', '3': 1, '4': 1, '5': 5, '10': 'emitBefore'},
    {'1': 'code', '3': 2, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `StreamFailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamFailRequestDescriptor = $convert.base64Decode(
    'ChFTdHJlYW1GYWlsUmVxdWVzdBIfCgtlbWl0X2JlZm9yZRgBIAEoBVIKZW1pdEJlZm9yZRISCg'
    'Rjb2RlGAIgASgFUgRjb2RlEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use streamFailResponseDescriptor instead')
const StreamFailResponse$json = {
  '1': 'StreamFailResponse',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `StreamFailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamFailResponseDescriptor = $convert
    .base64Decode('ChJTdHJlYW1GYWlsUmVzcG9uc2USFAoFaW5kZXgYASABKAVSBWluZGV4');

@$core.Deprecated('Use echoMetaRequestDescriptor instead')
const EchoMetaRequest$json = {
  '1': 'EchoMetaRequest',
  '2': [
    {'1': 'input', '3': 1, '4': 1, '5': 9, '10': 'input'},
  ],
};

/// Descriptor for `EchoMetaRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoMetaRequestDescriptor = $convert
    .base64Decode('Cg9FY2hvTWV0YVJlcXVlc3QSFAoFaW5wdXQYASABKAlSBWlucHV0');

@$core.Deprecated('Use echoMetaResponseDescriptor instead')
const EchoMetaResponse$json = {
  '1': 'EchoMetaResponse',
  '2': [
    {'1': 'input', '3': 1, '4': 1, '5': 9, '10': 'input'},
    {
      '1': 'meta',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.easyrpc.conformance.v1.EchoMetaResponse.MetaEntry',
      '10': 'meta'
    },
  ],
  '3': [EchoMetaResponse_MetaEntry$json],
};

@$core.Deprecated('Use echoMetaResponseDescriptor instead')
const EchoMetaResponse_MetaEntry$json = {
  '1': 'MetaEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `EchoMetaResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoMetaResponseDescriptor = $convert.base64Decode(
    'ChBFY2hvTWV0YVJlc3BvbnNlEhQKBWlucHV0GAEgASgJUgVpbnB1dBJGCgRtZXRhGAIgAygLMj'
    'IuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5FY2hvTWV0YVJlc3BvbnNlLk1ldGFFbnRyeVIEbWV0'
    'YRo3CglNZXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOg'
    'I4AQ==');

@$core.Deprecated('Use bigRequestDescriptor instead')
const BigRequest$json = {
  '1': 'BigRequest',
  '2': [
    {'1': 'size', '3': 1, '4': 1, '5': 5, '10': 'size'},
  ],
};

/// Descriptor for `BigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bigRequestDescriptor =
    $convert.base64Decode('CgpCaWdSZXF1ZXN0EhIKBHNpemUYASABKAVSBHNpemU=');

@$core.Deprecated('Use bigResponseDescriptor instead')
const BigResponse$json = {
  '1': 'BigResponse',
  '2': [
    {'1': 'size', '3': 2, '4': 1, '5': 5, '10': 'size'},
  ],
};

/// Descriptor for `BigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bigResponseDescriptor =
    $convert.base64Decode('CgtCaWdSZXNwb25zZRISCgRzaXplGAIgASgFUgRzaXpl');

@$core.Deprecated('Use failDetailsRequestDescriptor instead')
const FailDetailsRequest$json = {
  '1': 'FailDetailsRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'detail_type', '3': 3, '4': 1, '5': 9, '10': 'detailType'},
    {'1': 'detail_text', '3': 4, '4': 1, '5': 9, '10': 'detailText'},
  ],
};

/// Descriptor for `FailDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failDetailsRequestDescriptor = $convert.base64Decode(
    'ChJGYWlsRGV0YWlsc1JlcXVlc3QSEgoEY29kZRgBIAEoBVIEY29kZRIYCgdtZXNzYWdlGAIgAS'
    'gJUgdtZXNzYWdlEh8KC2RldGFpbF90eXBlGAMgASgJUgpkZXRhaWxUeXBlEh8KC2RldGFpbF90'
    'ZXh0GAQgASgJUgpkZXRhaWxUZXh0');

@$core.Deprecated('Use failDetailsResponseDescriptor instead')
const FailDetailsResponse$json = {
  '1': 'FailDetailsResponse',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
  ],
};

/// Descriptor for `FailDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failDetailsResponseDescriptor = $convert
    .base64Decode('ChNGYWlsRGV0YWlsc1Jlc3BvbnNlEg4KAm9rGAEgASgIUgJvaw==');

@$core.Deprecated('Use streamFailDetailsRequestDescriptor instead')
const StreamFailDetailsRequest$json = {
  '1': 'StreamFailDetailsRequest',
  '2': [
    {'1': 'emit_before', '3': 1, '4': 1, '5': 5, '10': 'emitBefore'},
    {'1': 'code', '3': 2, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'detail_type', '3': 4, '4': 1, '5': 9, '10': 'detailType'},
    {'1': 'detail_text', '3': 5, '4': 1, '5': 9, '10': 'detailText'},
  ],
};

/// Descriptor for `StreamFailDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamFailDetailsRequestDescriptor = $convert.base64Decode(
    'ChhTdHJlYW1GYWlsRGV0YWlsc1JlcXVlc3QSHwoLZW1pdF9iZWZvcmUYASABKAVSCmVtaXRCZW'
    'ZvcmUSEgoEY29kZRgCIAEoBVIEY29kZRIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEh8KC2Rl'
    'dGFpbF90eXBlGAQgASgJUgpkZXRhaWxUeXBlEh8KC2RldGFpbF90ZXh0GAUgASgJUgpkZXRhaW'
    'xUZXh0');

@$core.Deprecated('Use streamFailDetailsResponseDescriptor instead')
const StreamFailDetailsResponse$json = {
  '1': 'StreamFailDetailsResponse',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `StreamFailDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamFailDetailsResponseDescriptor =
    $convert.base64Decode(
        'ChlTdHJlYW1GYWlsRGV0YWlsc1Jlc3BvbnNlEhQKBWluZGV4GAEgASgFUgVpbmRleA==');

@$core.Deprecated('Use echoTrailerRequestDescriptor instead')
const EchoTrailerRequest$json = {
  '1': 'EchoTrailerRequest',
  '2': [
    {'1': 'input', '3': 1, '4': 1, '5': 9, '10': 'input'},
  ],
};

/// Descriptor for `EchoTrailerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoTrailerRequestDescriptor = $convert
    .base64Decode('ChJFY2hvVHJhaWxlclJlcXVlc3QSFAoFaW5wdXQYASABKAlSBWlucHV0');

@$core.Deprecated('Use echoTrailerResponseDescriptor instead')
const EchoTrailerResponse$json = {
  '1': 'EchoTrailerResponse',
  '2': [
    {'1': 'output', '3': 1, '4': 1, '5': 9, '10': 'output'},
  ],
};

/// Descriptor for `EchoTrailerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List echoTrailerResponseDescriptor =
    $convert.base64Decode(
        'ChNFY2hvVHJhaWxlclJlc3BvbnNlEhYKBm91dHB1dBgBIAEoCVIGb3V0cHV0');

@$core.Deprecated('Use countTrailerRequestDescriptor instead')
const CountTrailerRequest$json = {
  '1': 'CountTrailerRequest',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
  ],
};

/// Descriptor for `CountTrailerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countTrailerRequestDescriptor =
    $convert.base64Decode(
        'ChNDb3VudFRyYWlsZXJSZXF1ZXN0EhQKBWNvdW50GAEgASgFUgVjb3VudA==');

@$core.Deprecated('Use countTrailerResponseDescriptor instead')
const CountTrailerResponse$json = {
  '1': 'CountTrailerResponse',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 5, '10': 'index'},
  ],
};

/// Descriptor for `CountTrailerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countTrailerResponseDescriptor =
    $convert.base64Decode(
        'ChRDb3VudFRyYWlsZXJSZXNwb25zZRIUCgVpbmRleBgBIAEoBVIFaW5kZXg=');

const $core.Map<$core.String, $core.dynamic> ConformanceServiceBase$json = {
  '1': 'ConformanceService',
  '2': [
    {
      '1': 'Health',
      '2': '.easyrpc.conformance.v1.HealthRequest',
      '3': '.easyrpc.conformance.v1.HealthResponse'
    },
    {
      '1': 'Echo',
      '2': '.easyrpc.conformance.v1.EchoRequest',
      '3': '.easyrpc.conformance.v1.EchoResponse'
    },
    {
      '1': 'Count',
      '2': '.easyrpc.conformance.v1.CountRequest',
      '3': '.easyrpc.conformance.v1.CountResponse',
      '6': true
    },
    {
      '1': 'Fail',
      '2': '.easyrpc.conformance.v1.FailRequest',
      '3': '.easyrpc.conformance.v1.FailResponse'
    },
    {
      '1': 'StreamFail',
      '2': '.easyrpc.conformance.v1.StreamFailRequest',
      '3': '.easyrpc.conformance.v1.StreamFailResponse',
      '6': true
    },
    {
      '1': 'EchoMeta',
      '2': '.easyrpc.conformance.v1.EchoMetaRequest',
      '3': '.easyrpc.conformance.v1.EchoMetaResponse'
    },
    {
      '1': 'Big',
      '2': '.easyrpc.conformance.v1.BigRequest',
      '3': '.easyrpc.conformance.v1.BigResponse'
    },
    {
      '1': 'FailDetails',
      '2': '.easyrpc.conformance.v1.FailDetailsRequest',
      '3': '.easyrpc.conformance.v1.FailDetailsResponse'
    },
    {
      '1': 'StreamFailDetails',
      '2': '.easyrpc.conformance.v1.StreamFailDetailsRequest',
      '3': '.easyrpc.conformance.v1.StreamFailDetailsResponse',
      '6': true
    },
    {
      '1': 'EchoTrailer',
      '2': '.easyrpc.conformance.v1.EchoTrailerRequest',
      '3': '.easyrpc.conformance.v1.EchoTrailerResponse'
    },
    {
      '1': 'CountTrailer',
      '2': '.easyrpc.conformance.v1.CountTrailerRequest',
      '3': '.easyrpc.conformance.v1.CountTrailerResponse',
      '6': true
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
  '.easyrpc.conformance.v1.StreamFailRequest': StreamFailRequest$json,
  '.easyrpc.conformance.v1.StreamFailResponse': StreamFailResponse$json,
  '.easyrpc.conformance.v1.EchoMetaRequest': EchoMetaRequest$json,
  '.easyrpc.conformance.v1.EchoMetaResponse': EchoMetaResponse$json,
  '.easyrpc.conformance.v1.EchoMetaResponse.MetaEntry':
      EchoMetaResponse_MetaEntry$json,
  '.easyrpc.conformance.v1.BigRequest': BigRequest$json,
  '.easyrpc.conformance.v1.BigResponse': BigResponse$json,
  '.easyrpc.conformance.v1.FailDetailsRequest': FailDetailsRequest$json,
  '.easyrpc.conformance.v1.FailDetailsResponse': FailDetailsResponse$json,
  '.easyrpc.conformance.v1.StreamFailDetailsRequest':
      StreamFailDetailsRequest$json,
  '.easyrpc.conformance.v1.StreamFailDetailsResponse':
      StreamFailDetailsResponse$json,
  '.easyrpc.conformance.v1.EchoTrailerRequest': EchoTrailerRequest$json,
  '.easyrpc.conformance.v1.EchoTrailerResponse': EchoTrailerResponse$json,
  '.easyrpc.conformance.v1.CountTrailerRequest': CountTrailerRequest$json,
  '.easyrpc.conformance.v1.CountTrailerResponse': CountTrailerResponse$json,
};

/// Descriptor for `ConformanceService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List conformanceServiceDescriptor = $convert.base64Decode(
    'ChJDb25mb3JtYW5jZVNlcnZpY2USVwoGSGVhbHRoEiUuZWFzeXJwYy5jb25mb3JtYW5jZS52MS'
    '5IZWFsdGhSZXF1ZXN0GiYuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5IZWFsdGhSZXNwb25zZRJR'
    'CgRFY2hvEiMuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5FY2hvUmVxdWVzdBokLmVhc3lycGMuY2'
    '9uZm9ybWFuY2UudjEuRWNob1Jlc3BvbnNlElYKBUNvdW50EiQuZWFzeXJwYy5jb25mb3JtYW5j'
    'ZS52MS5Db3VudFJlcXVlc3QaJS5lYXN5cnBjLmNvbmZvcm1hbmNlLnYxLkNvdW50UmVzcG9uc2'
    'UwARJRCgRGYWlsEiMuZWFzeXJwYy5jb25mb3JtYW5jZS52MS5GYWlsUmVxdWVzdBokLmVhc3ly'
    'cGMuY29uZm9ybWFuY2UudjEuRmFpbFJlc3BvbnNlEmUKClN0cmVhbUZhaWwSKS5lYXN5cnBjLm'
    'NvbmZvcm1hbmNlLnYxLlN0cmVhbUZhaWxSZXF1ZXN0GiouZWFzeXJwYy5jb25mb3JtYW5jZS52'
    'MS5TdHJlYW1GYWlsUmVzcG9uc2UwARJdCghFY2hvTWV0YRInLmVhc3lycGMuY29uZm9ybWFuY2'
    'UudjEuRWNob01ldGFSZXF1ZXN0GiguZWFzeXJwYy5jb25mb3JtYW5jZS52MS5FY2hvTWV0YVJl'
    'c3BvbnNlEk4KA0JpZxIiLmVhc3lycGMuY29uZm9ybWFuY2UudjEuQmlnUmVxdWVzdBojLmVhc3'
    'lycGMuY29uZm9ybWFuY2UudjEuQmlnUmVzcG9uc2USZgoLRmFpbERldGFpbHMSKi5lYXN5cnBj'
    'LmNvbmZvcm1hbmNlLnYxLkZhaWxEZXRhaWxzUmVxdWVzdBorLmVhc3lycGMuY29uZm9ybWFuY2'
    'UudjEuRmFpbERldGFpbHNSZXNwb25zZRJ6ChFTdHJlYW1GYWlsRGV0YWlscxIwLmVhc3lycGMu'
    'Y29uZm9ybWFuY2UudjEuU3RyZWFtRmFpbERldGFpbHNSZXF1ZXN0GjEuZWFzeXJwYy5jb25mb3'
    'JtYW5jZS52MS5TdHJlYW1GYWlsRGV0YWlsc1Jlc3BvbnNlMAESZgoLRWNob1RyYWlsZXISKi5l'
    'YXN5cnBjLmNvbmZvcm1hbmNlLnYxLkVjaG9UcmFpbGVyUmVxdWVzdBorLmVhc3lycGMuY29uZm'
    '9ybWFuY2UudjEuRWNob1RyYWlsZXJSZXNwb25zZRJrCgxDb3VudFRyYWlsZXISKy5lYXN5cnBj'
    'LmNvbmZvcm1hbmNlLnYxLkNvdW50VHJhaWxlclJlcXVlc3QaLC5lYXN5cnBjLmNvbmZvcm1hbm'
    'NlLnYxLkNvdW50VHJhaWxlclJlc3BvbnNlMAE=');
