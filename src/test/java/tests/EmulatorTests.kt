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
            val fetchedAccount = apiSbpCustomerAccount.fetchCustomerAccount() // отправляется здесь, чтобы переиспользовать ответ

            AssertMethods.checkName(fetchedAccount = fetchedAccount)
            AssertMethods.checkBankAccounts(fetchedAccount = fetchedAccount)
        }

        @Test
        fun setAccountDefault() {
            val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
            apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

            AssertMethods.setDefaultAccountSuccess()
        }

        @Test
        fun checkBanks() {
            AssertMethods.checkBanksReference()
        }
    }

