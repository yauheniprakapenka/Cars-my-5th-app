    package tests

    import api.apiRequests.ApiSbpBank
    import api.apiScript.ApiScriptAuthorizeToProfile
    import asserts.AssertMethods
    import asserts.SbpBankAsserts
    import asserts.SbpCustomerAccountAsserts
    import constants.BanksJSONConstant
    import constants.PhoneConstant
    import org.junit.Assert
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
            val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
            apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

            AssertMethods.setDefaultAccountSuccess()
        }

        @Test
        fun notEqualState() {

            // Expected banks
            val expectedBanksModel = BanksJSONConstant.getBanksFromLocalFile()
            val expectedBanksCount = expectedBanksModel.count()
            val expectedBanksNameList = mutableListOf<String>()
            for (index in 0 until expectedBanksCount) {
                expectedBanksNameList.add(expectedBanksModel[index].name)
            }

            // Fetched banks
            val fetchedBanksModel = ApiSbpBank.fetchBank()
            val fetchedBanksCount = fetchedBanksModel.count()
            val fetchedBanksNameList = mutableListOf<String>()
            for (index in 0 until fetchedBanksCount) {
                fetchedBanksNameList.add(fetchedBanksModel[index].name)
            }

            // Left banks
            val leftExpectedBanksNameList = expectedBanksNameList.toMutableList()
            val leftFetchedBanksNameList = fetchedBanksNameList.toMutableList()

            // Count
            var count = 0

            if (expectedBanksCount < fetchedBanksCount) count = expectedBanksCount
            else if (expectedBanksCount > fetchedBanksCount) count = fetchedBanksCount
            else {
                println("Error: Unknown count state")
                Assert.assertTrue(false)
            }

            // Processing
            for (index in 0 until count) {
                val bank = expectedBanksNameList[index]
                leftExpectedBanksNameList.remove(bank)
                leftFetchedBanksNameList.remove(bank)
            }

            // Result
            println("Error: Bank reference is different")
            println("expectedBanksModel $expectedBanksCount\nfetchedBanksCount $fetchedBanksCount")
            println("leftExpectedBanksNameList:\n$leftExpectedBanksNameList")
            println("leftFetchedBanksNameList:\n$leftFetchedBanksNameList")

            Assert.assertTrue(false)
        }

        @Test
        fun two() {
            val a = true && false
            println(a)

            val b = false || true
            println(b)
        }
    }

