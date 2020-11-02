package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import khttp.post
import org.junit.Assert

class ApiSbpTransferTokenAuthenticationConfirm {
    fun fetchTransferTokenAuthenticationConfirm() {
        val response = post(ApiURLConstants.sbpTransferTokenAuthenticationConfirm, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("authCode" to "1111"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }
}