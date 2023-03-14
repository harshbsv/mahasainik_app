class ApiEndpoints {
  static const baseUrl = 'https://mahasainikstore.com/api';
  static const getNearestStore = '$baseUrl/nearbystore/';
  static const getBaskets = '$baseUrl/baskets/';
  static const getProducts = '$baseUrl/products/?store_id=1&limit=100&offset=0';
  static const registerUser = '$baseUrl/register/';
  static const addToCart = '$baseUrl/basket/add-product/';
  static const getOrders = '$baseUrl/orders/';
  static const getCategories = '$baseUrl/categories/';
  static const sendOTP = '$baseUrl/v1/auth/mobile/';
  static const verifyOTP = '$baseUrl/v1/auth/token/';
  static const getProfile = '$baseUrl/profile/';
  static const updateProfile = '$baseUrl/profile/';
  static const logout = '$baseUrl/logout/';
  static const userAddresses = '$baseUrl/useraddresses/';
  static const checkout = '$baseUrl/checkout/';
  static const bestSelling =
      '$baseUrl/products/bestselling/?store_id=1&limit=10&offset=0';
  static const babyCareCategory = '$baseUrl/categories/baby-care';
  static const freshFruitsCategory = '$baseUrl/categories/fresh-fruits';
  static const dailyEssentials = '$baseUrl/categories/grocery/';
  static const skinCare = '$baseUrl/categories/skin-care';
}
