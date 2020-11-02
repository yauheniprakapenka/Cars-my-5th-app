package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import constants.BankConstant
import khttp.post
import org.junit.Assert

class ApiSbpCustomerDefaultAccountSet {

    fun fetchDefaultAccountSet() {
        val response = post(ApiURLConstants.sbpCustomerDefaultAccountSet, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("account" to BankConstant.account, "bankId" to BankConstant.transstroybank100000000197))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        println("\n" + response.statusCode + " Счет успешно установлен\n")
    }
}