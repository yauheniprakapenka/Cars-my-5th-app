package asserts

import api.apiRequests.ApiSbpBank
import constants.BanksJSONConstant
import org.junit.Assert

/*
Проверяет локальный справочник банков с полученным от сервера справочником. Сравнивает их по названию.

Состояния:
1. Количество банков совпадает
   |-> Совпали все имена
   |-> Имена не совпали
2. Количество банков не совпало
   |-> Локальных банков больше, чем полученных
   |-> Локальных банков меньше, чем полученных
 */

object SbpBankAsserts {

    private val expectedBanksModel = BanksJSONConstant.getBanksFromLocalFile()
    private val expectedBanksNameList = mutableListOf<String>()

    private val fetchedBanksModel = ApiSbpBank.fetchBank()
    private val fetchedBanksNameList = mutableListOf<String>()

    private var leftExpectedBanksNameList = mutableListOf<String>()
    private var leftFetchedBanksNameList = mutableListOf<String>()

    fun verify() {

        // Expected banks
        val expectedBanksCount = expectedBanksModel.count()
        for (index in 0 until expectedBanksCount) {
            expectedBanksNameList.add(expectedBanksModel[index].name)
        }

        // Fetched banks
        val fetchedBanksCount = fetchedBanksModel.count()
        for (index in 0 until fetchedBanksCount) {
            fetchedBanksNameList.add(fetchedBanksModel[index].name)
        }

        leftExpectedBanksNameList = expectedBanksNameList.toMutableList()
        leftFetchedBanksNameList = fetchedBanksNameList.toMutableList()

        // Left banks

        when (expectedBanksCount == fetchedBanksCount) {
            true -> {
                // Count
                val count = expectedBanksCount

                // Filtering
                for (index in 0 until count) {
                    val bank = expectedBanksNameList[index]
                    leftExpectedBanksNameList.remove(bank)
                    leftFetchedBanksNameList.remove(bank)
                }

                // Verifying
                val leftExpectedBanksNameListIsEmpty = leftExpectedBanksNameList.isEmpty()
                val leftFetchedBanksNameListIsEmpty = leftFetchedBanksNameList.isEmpty()

                val bothListAreEmpty = leftExpectedBanksNameListIsEmpty && leftFetchedBanksNameListIsEmpty

                when (bothListAreEmpty) {
                    true -> {
                        println("Successful: banks reference match")
                        Assert.assertTrue((true))
                    }
                    false -> {
                        println("Error: the number of banks is the same, but the name does not match")
                        printLeftBanksList()
                        Assert.assertTrue(false)
                    }
                }
            }
            false -> {
                // Count
                var count = 0


                if (expectedBanksCount < fetchedBanksCount) {
                    println("expectedBanksCount < fetchedBanksCount")
                    count = expectedBanksCount
                    println("count $count")
                    for (index in 0 until count) {
                        val bank = expectedBanksNameList[index]
                        leftExpectedBanksNameList.remove(bank)
                        leftFetchedBanksNameList.remove(bank)
                    }
                } else if (expectedBanksCount > fetchedBanksCount) {
                    println("expectedBanksCount > fetchedBanksCount")
                    println("count $count")
                    count = fetchedBanksCount
                    for (index in 0 until count) {
                        val bank = fetchedBanksNameList[index]
                        leftExpectedBanksNameList.remove(bank)
                        leftFetchedBanksNameList.remove(bank)
                    }
                }


                // Result
                println("Error: Bank reference is different")
                println("expectedBanksModel $expectedBanksCount\nfetchedBanksCount $fetchedBanksCount")
                printLeftBanksList()

                Assert.assertTrue(false)
            }
        }
    }

    private fun printLeftBanksList() {
        println("Left Expected Banks Name List:\n$leftExpectedBanksNameList")
        println("Left Fetched Banks Name List:\n$leftFetchedBanksNameList")
    }
}