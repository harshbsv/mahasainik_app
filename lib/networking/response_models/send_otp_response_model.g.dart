// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOTPResponseModel _$SendOTPResponseModelFromJson(
        Map<String, dynamic> json) =>
    SendOTPResponseModel(
      json['detail'] as String?,
      json['otp'] as String?,
    );

Map<String, dynamic> _$SendOTPResponseModelToJson(
        SendOTPResponseModel instance) =>
    <String, dynamic>{
      'detail': instance.details,
      'otp': instance.otp,
    };
