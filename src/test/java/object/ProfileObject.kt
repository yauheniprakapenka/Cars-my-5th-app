package `object`

object ProfileObject {
    var profile = ""
    var sessionId = ""
    var deviceId = ""
    var deviceToken = ""
    var token = ""
    var paymentToken = ""
    var fpMessageId = ""
    var controlValue = ""
    var error = ""

    val profileObject: String
        get() = "\nДанные профиля\nprofile: $profile\nsessionId: $sessionId\ndeviceId: $deviceId\ndeviceToken: $deviceToken\ntoken: $token\npaymentToken: $paymentToken\nfpMessageId: $fpMessageId\ncontrolValue: $controlValue\nerror: $error\n"
}