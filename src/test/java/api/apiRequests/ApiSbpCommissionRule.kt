package api.apiRequests

import api.apiConfigure.ApiURLConstants
import constants.BanksIdConstant

import khttp.get
import org.junit.Assert

class ApiSbpCommissionRule {

    fun fetchCommissionRule() {
        val response = get(ApiURLConstants.sbpCommissionRule + "?bankId=${BanksIdConstant.transstroybank100000000197}&account=${BanksIdConstant.account}")
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }

}