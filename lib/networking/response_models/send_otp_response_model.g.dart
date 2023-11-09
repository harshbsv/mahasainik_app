// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpResponseModel _$SendOtpResponseModelFromJson(
        Map<String, dynamic> json) =>
    SendOtpResponseModel(
      detail: json['detail'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$SendOtpResponseModelToJson(
        SendOtpResponseModel instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'otp': instance.otp,
    };
