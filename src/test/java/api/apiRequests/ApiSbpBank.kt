package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import khttp.get
import org.junit.Assert

class ApiSbpBank {
    fun fetchBank() {
        val response = get(ApiURLConstants.sbpBank, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }
}