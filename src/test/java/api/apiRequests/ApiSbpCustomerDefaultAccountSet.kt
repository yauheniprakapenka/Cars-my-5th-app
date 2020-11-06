package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import constants.BanksIdConstant
import khttp.post

class ApiSbpCustomerDefaultAccountSet {

    fun fetchDefaultAccountSet(): Int {
        val header = mapOf(
                "X-IV-Authorization" to "Session ${ProfileObject.sessionId}"
        )
        val data = mapOf(
                "account" to BanksIdConstant.account,
                "bankId" to BanksIdConstant.transstroybank100000000197
        )
        val response = post(
                ApiURLConstants.sbpCustomerDefaultAccountSet,
                headers = header,
                data = data)

        val json = response.text
        println("\n${json}\n")

        println("\n" + response.statusCode + " Счет успешно установлен\n")
        return response.statusCode
    }
}