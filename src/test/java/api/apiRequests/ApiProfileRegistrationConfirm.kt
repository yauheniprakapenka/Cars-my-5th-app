package api.apiRequests

import com.google.gson.Gson
import constants.SMSConstants
import api.apiConfigure.ApiURLConstants
import io.qameta.allure.Step
import khttp.post
import `object`.ProfileObject
import org.junit.Assert.assertTrue

data class ProfileRegistrationConfirmModel(
        val sessionId: String = "",
        val deviceId: String = "",
        val deviceToken: String = ""
)

class ApiProfileRegistrationConfirm {

    @Step("apiProfileRegistrationConfirm")
    fun api_profile_registration_confirm(profileNumber: String) {
        val response = post(ApiURLConstants.profileRegistrationConfirm, data = mapOf("msisdn" to profileNumber, "otp" to SMSConstants.sms1111))
        assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        val gson = Gson()
        val profileRegistrationConfirmModel = gson.fromJson(json, ProfileRegistrationConfirmModel::class.java)

        ProfileObject.sessionId = profileRegistrationConfirmModel.sessionId
        ProfileObject.deviceId = profileRegistrationConfirmModel.deviceId
        ProfileObject.deviceToken = profileRegistrationConfirmModel.deviceToken
    }

}
