package asserts

import api.apiRequests.ApiSbpBank
import api.apiRequests.ApiSbpCustomerDefaultAccountSet
import constants.BanksJSONConstant
import org.junit.Assert

object AssertMethods {


    fun setDefaultAccountSuccess() {
        val apiSbpCustomerDefaultAccountSet = ApiSbpCustomerDefaultAccountSet()
        val statusCode = apiSbpCustomerDefaultAccountSet.fetchDefaultAccountSet()
        Assert.assertTrue(statusCode == 200)
    }


}