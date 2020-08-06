package api.apiRequests

import api.apiConfigure.ApiURLConstants
import io.qameta.allure.Step
import khttp.post

class ApiProfileRegistrationStart {

    @Step("api_profile_registration_start")
    fun api_profile_registration_start(profileNumber: String): Int {
        val response = post(ApiURLConstants.profileRegistrationStart, data = mapOf("msisdn" to profileNumber))
        return response.statusCode
    }

}