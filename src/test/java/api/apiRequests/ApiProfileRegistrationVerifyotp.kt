package api.apiRequests

import constants.SMSConstants
import api.apiConfigure.ApiURLConstants
import io.qameta.allure.Step
import khttp.post
import org.junit.Assert.assertTrue

class ApiProfileRegistrationVerifyotp {

    @Step("api_profile_registration_verify_otp")
    fun api_profile_registration_verify_otp(profileNumber: String) {
        val response = post(ApiURLConstants.profileRegistrationVerifyotp, data = mapOf("msisdn" to profileNumber, "otp" to SMSConstants.sms1111))
        assertTrue(response.statusCode == 200)
    }

}