const int kApiUnknownErrorCode = 0;
const int kApiCanceledCode = -1;
const int kApiConnectionTimeoutCode = -2;
const int kApiDefaultCode = -3;
const int kApiReceiveTimeoutCode = -4;
const int kApiSendTimeoutCode = -5;
const int kApiHandshakeExceptionErrorCode = -6;

const String kApiUnknownError = 'UNKNOWN_ERROR';
const String kApiCanceled = 'API_CANCELED';
const String kApiConnectionTimeout = 'CONNECT_TIMEOUT';
const String kApiDefault = 'DEFAULT';
const String kApiReceiveTimeout = 'RECEIVE_TIMEOUT';
const String kApiSendTimeout = 'SEND_TIMEOUT';
const String kApiResponseError = 'RESPONSE_ERROR';

// Common masked error messages
const String kErrorMessageConnectionTimeout = 'Connection timed out';
const String kErrorMessageNetworkError = 'Network error';
const String kErrorMessageGenericError = 'Something went wrong';

// HandshakeException
const String kHandshakeExceptionTypeKey =
    'HandshakeException'; // Used in comparison
const String kApiHandshakeExceptionError = 'HANDSHAKE_EXCEPTION';
const String kErrorMessageHandshakeException = 'Handshake Exception';
