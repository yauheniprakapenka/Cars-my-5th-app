    package tests

    import api.apiRequests.ApiSbpCustomerAccount
    import api.apiRequests.ApiSbpCustomerDefaultAccountSet
    import api.apiScript.ApiScriptAuthorizeToProfile
    import assertMethods.AssertMethods
    import constants.PhoneConstant
    import org.junit.Assert
    import org.junit.Test

    class EmulatorTests {

        @Test
        fun checkAccount() {
            val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
            apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

            val apiSbpCustomerAccount = ApiSbpCustomerAccount()
            val fetchedAccount = apiSbpCustomerAccount.fetchCustomerAccount()

            // Asserts
            val assertMethods = AssertMethods()
            assertMethods.checkName(fetchedAccount = fetchedAccount)
            assertMethods.checkBankAccounts(fetchedAccount = fetchedAccount)
        }

        @Test
        fun setAccountDefault() {
            val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
            apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

            // Asserts
            val assertMethods = AssertMethods()
            assertMethods.setDefaultAccountSuccess()
        }
    }

