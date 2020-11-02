package api.apiRequests

import api.apiConfigure.ApiURLConstants
import constants.BankConstant

import khttp.get
import org.junit.Assert

class ApiSbpCommissionRule {

    fun fetchCommissionRule() {
        val response = get(ApiURLConstants.sbpCommissionRule + "?bankId=${BankConstant.transstroybank100000000197}&account=${BankConstant.account}")
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }

}