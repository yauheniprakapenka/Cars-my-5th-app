package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import khttp.get
import org.junit.Assert

// получить результат платежа
class ApiSbpTransferToken {

    fun fetchTransferToken() {
        val response = get(ApiURLConstants.sbpTransferToken, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }
}