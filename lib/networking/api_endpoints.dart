class ApiEndpoints {
  static const baseUrl = 'https://mahasainikstore.com/api';
  static const getNearestStore = '$baseUrl/nearbystore/';
  static const getBaskets = '$baseUrl/baskets/';
  static const getProducts = '$baseUrl/products/?store_id=1&limit=100&offset=0';
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
      '$baseUrl/products/bestselling/?store_id=1&limit=20&offset=0';
  static const subCategory =
      '$baseUrl/categories/grocery/products/?store_id=1&limit=20&offset=0';
  static const getSearchedProducts =
      '$baseUrl/products/search/?store_id=1&q=surf&limit=2&offset=0';
}
