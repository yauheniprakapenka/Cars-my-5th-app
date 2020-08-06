package api.apiConfigure

import `object`.ProfileObject

object ApiURLConstants {

    private val baseUrl = ApiURLConfiguration().apiURL

    val profileRegistrationStart: String
        get() = "$baseUrl/profile/registration/start"

    val sessionStart2fa: String
        get() = "$baseUrl/session/start-2fa"

    val sessionConfirm2fa: String
        get() = "$baseUrl/session/confirm-2fa"

    val profileRegistrationVerifyotp: String
        get() = "$baseUrl/profile/registration/verify-otp"

    val profileRegistrationConfirm: String
        get() = "$baseUrl/profile/registration/confirm"

    val token: String
        get() = "$baseUrl/token"

    val payment: String
        get() = "$baseUrl/payment"

    val sbpCustomerAccount: String
        get() = "$baseUrl/sbp/customer/account"

    val sbpBank: String
        get() = "$baseUrl/sbp/bank"

    val sbpCustomerDefaultAccountSet: String
        get() = "$baseUrl/sbp/customer/default-account/set"

    val sbpCustomerDefaultBankStartModification: String
        get() = "$baseUrl/sbp/customer/default-bank/start-modification"

    val sbpCustomerDefaultBankConfirmModification: String
        get() = "$baseUrl/sbp/customer/default-bank/confirm-modification"

    val sbpCommissionRule: String
        get() = "$baseUrl/sbp/commission/rule"

    val sbpFindRecipient: String
        get() = "$baseUrl/sbp/find-recipient"

    val sbpTransferTokenStart: String
        get() = "$baseUrl/sbp/transfer/${ProfileObject.token}/start"

    val sbpTransferTokenAccept : String
        get() = "$baseUrl/sbp/transfer/${ProfileObject.token}/accept"

    val sbpTransferTokenAuthenticationConfirm: String
        get() = "$baseUrl/sbp/transfer/${ProfileObject.token}/authentication-confirm"

    val sbpTransferToken: String
        get() = "$baseUrl/sbp/transfer/${ProfileObject.token}"
}
