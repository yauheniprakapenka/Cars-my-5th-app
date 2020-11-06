package asserts

import api.apiRequests.ApiSbpBank
import constants.BanksJSONConstant

object SbpBankAsserts {
    fun verify() {
        // Expected banks
        val expectedBanksModel = BanksJSONConstant.getBanksFromLocalFile()
        val expectedBanksCount = expectedBanksModel.count()

        val expectedBanksNameList = mutableListOf<String>()
        for (index in 0 until expectedBanksCount) {
            expectedBanksNameList += expectedBanksModel[index].name
        }

        // Fetched banks
        val fetchedBanksModel = ApiSbpBank.fetchBank()
        val fetchedBanksCount = fetchedBanksModel.count()

        val fetchedBanksNameList = mutableListOf<String>()
        for (index in 0 until fetchedBanksCount) {
            fetchedBanksNameList += fetchedBanksModel[index].name
        }

        print("expected Banks Count: ${expectedBanksCount}\n")
        print("fetched Banks Count: ${fetchedBanksCount}")


//
////        val expectedBanksCount = 193
//        Assert.assertTrue(expectedBanksConstantCount == expectedBanksCount)
//        if (fetchedBanksCount == expectedBanksCount) {
//            Assert.assertTrue(true)
//        } else {
//            print("Количество банков отличается на ${kotlin.math.abs(fetchedBanksCount - expectedBanksCount)}\n")
//            Assert.assertTrue(false)
//        }
//
//        for (index in 0 until fetchedBanksList.count()) {
//            if (expectedBanksList.contains(fetchedBanksList[index].name)) {
//                Assert.assertTrue(true)
//            } else {
//                print("Полученный ${fetchedBanksList[index].name} отсутствует в константе банков")
//                Assert.assertTrue(false)
//            }
//        }



    }
}