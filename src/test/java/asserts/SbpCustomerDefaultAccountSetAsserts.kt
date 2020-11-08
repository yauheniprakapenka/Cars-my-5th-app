package asserts

import api.apiRequests.ApiSbpCustomerDefaultAccountSet
import api.apiScript.ApiScriptAuthorizeToProfile
import constants.PhoneConstant
import org.junit.Assert

/*
Запрос на установку счета для зачислений
 */

object SbpCustomerDefaultAccountSetAsserts {
    fun setSuccess() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

        val apiSbpCustomerDefaultAccountSet = ApiSbpCustomerDefaultAccountSet.set()
        val fetchedStatusCode = apiSbpCustomerDefaultAccountSet.statusCode

        when (fetchedStatusCode) {
            200 -> {
                println("Success: set default account for credit")
                Assert.assertTrue(true)
            }
            else -> {
                println("Error: set default account for credit")
                Assert.assertTrue(false)
            }
        }
    }
}