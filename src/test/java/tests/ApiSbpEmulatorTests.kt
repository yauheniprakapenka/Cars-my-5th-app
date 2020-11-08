    package tests

    import api.apiScript.ApiScriptAuthorizeToProfile
    import asserts.SbpCustomerDefaultAccountSetAsserts
    import asserts.SbpBankAsserts
    import asserts.SbpCustomerAccountAsserts
    import constants.PhoneConstant
    import org.junit.Test

    class ApiSbpEmulatorTests {

        @Test
        fun verifySbpCustomerAccount() {
            SbpCustomerAccountAsserts.verify()
        }

        @Test
        fun verifySbpBank() {
            SbpBankAsserts.verify()
        }

        @Test
        fun setAccountDefault() {
            SbpCustomerDefaultAccountSetAsserts.setSuccess()
        }

    }

