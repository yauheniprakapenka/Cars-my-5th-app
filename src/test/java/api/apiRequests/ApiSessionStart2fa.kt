package api.apiRequests

import com.google.gson.Gson
import api.apiConfigure.ApiURLConstants
import io.qameta.allure.Step
import khttp.post
import `object`.ProfileObject
import org.junit.Assert.assertTrue

private data class SessionStart2faModel(
        val deviceId: String = ""
)

class ApiSessionStart2fa {

    @Step("fetchSessionStart2fa")
    fun fetchSessionStart2fa(profileNumber: String) {
        val response = post(ApiURLConstants.sessionStart2fa, data = mapOf("msisdn" to profileNumber))
        assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        val gson = Gson()
        val sessionStart2faModel = gson.fromJson(json, SessionStart2faModel::class.java)

        ProfileObject.deviceId = sessionStart2faModel.deviceId
    }

}