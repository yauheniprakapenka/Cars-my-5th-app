package api.apiRequests

import api.apiConfigure.ApiURLConstants
import constants.SBPConstants

import khttp.get
import org.junit.Assert

class ApiSbpCommissionRule {

    fun sbpCommissionRule() {
        val response = get(ApiURLConstants.sbpCommissionRule + "?bankId=${SBPConstants.bankId10197}&account=${SBPConstants.account}")
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }

}