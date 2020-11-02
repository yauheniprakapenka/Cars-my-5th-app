package api.apiRequests

import com.google.gson.Gson
import constants.SMSConstant
import api.apiConfigure.ApiURLConstants
import io.qameta.allure.Step
import khttp.post
import `object`.ProfileObject
import org.junit.Assert.assertTrue

private data class SessionConfirm2faModel(
        val sessionId: String = "",
        val deviceToken: String = ""
)

class ApiSessionConfirm2fa {

    @Step("apiSessionConfirm2fa")
    fun fetchSessionConfirm2fa(profileNumber: String) {
        val response = post(ApiURLConstants.sessionConfirm2fa, data = mapOf("msisdn" to profileNumber, "deviceId" to ProfileObject.deviceId, "otp" to SMSConstant.sms1111))
        assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        val gson = Gson()
        val sessionConfirm2faModel = gson.fromJson(json, SessionConfirm2faModel::class.java)

        ProfileObject.sessionId = sessionConfirm2faModel.sessionId
        ProfileObject.deviceToken = sessionConfirm2faModel.deviceToken
    }

}
