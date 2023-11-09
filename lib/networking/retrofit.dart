import 'package:dio/dio.dart';
import 'package:mahasainik_app/networking/api_endpoints.dart';
import 'package:mahasainik_app/networking/request_models/nearby_store_request_model.dart';
import 'package:mahasainik_app/networking/request_models/send_otp_request_model.dart';
import 'package:mahasainik_app/networking/request_models/verify_otp_request_model.dart';
import 'package:mahasainik_app/networking/response_models/best_selling_response_model.dart';
import 'package:mahasainik_app/networking/response_models/categories_response_model.dart';
import 'package:mahasainik_app/networking/response_models/nearby_stores_response_model.dart';
import 'package:mahasainik_app/networking/response_models/products_response_model.dart';
import 'package:mahasainik_app/networking/response_models/search_response_model.dart';
import 'package:mahasainik_app/networking/response_models/send_otp_response_model.dart';
import 'package:mahasainik_app/networking/response_models/user_profile_response_model.dart';
import 'package:mahasainik_app/networking/response_models/verify_otp_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.sendOTP)
  Future<SendOtpResponseModel> sendOTP(
    @Body() SendOtpRequestModel requestModel,
  );

  @POST(ApiEndpoints.verifyOTP)
  Future<VerifyOtpResponseModel> verifyOTP(
    @Body() VerifyOtpRequestModel requestModel,
  );

  @GET(ApiEndpoints.bestSelling)
  Future<BestSellingResponseModel> getBestSelling(
    @Header('Authorization') String token,
    @Query('store_id') int storeId,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET(ApiEndpoints.getProducts)
  Future<ProductsResponseModel> getProducts(
    @Query('store_id') int storeId,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET(ApiEndpoints.getCategories)
  Future<List<CategoriesResponseModel>> getCategories();

  @POST(ApiEndpoints.getNearestStore)
  Future<NearbyStoresResponseModel> getNearbyStore(
    @Header('Authorization') String token,
    @Body() NearbyStoresRequestModel requestModel,
  );

  @GET(ApiEndpoints.getSearchedProducts)
  Future<SearchResponseModel> getSearchedProducts(
    @Query('store_id') int storeId,
    @Query('q') String searchQuery,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET(ApiEndpoints.getProfile)
  Future<UserProfileResponseModel> getProfile(
    @Header('Authorization') String token,
  );
}
