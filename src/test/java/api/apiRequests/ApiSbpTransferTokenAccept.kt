package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import khttp.post
import org.junit.Assert

class ApiSbpTransferTokenAccept {

    fun sbpTransferTokenAccept() {
        val response = post(ApiURLConstants.sbpTransferTokenAccept, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("test" to "test"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }
}