package api.apiRequests

import com.google.gson.Gson
import api.apiConfigure.ApiURLConstants

import khttp.post
import `object`.ProfileObject
import org.junit.Assert.assertTrue

private data class TokenModel(
        val token: String = ""
)

class ApiToken {

    fun getToken() {
        val response = post(ApiURLConstants.token, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("test" to "test"))
        assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        val gson = Gson()
        val tokenModel = gson.fromJson(json, TokenModel::class.java)

        ProfileObject.token = tokenModel.token
    }
}