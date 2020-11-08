package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import constants.BanksIdConstant
import khttp.post
import khttp.responses.Response

object ApiSbpCustomerDefaultAccountSet {

    fun set(): Response {
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

        return response
    }
}