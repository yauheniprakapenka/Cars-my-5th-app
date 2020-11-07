package asserts

import api.apiRequests.ApiSbpCustomerAccount
import api.apiRequests.CustomerAccountModel
import api.apiScript.ApiScriptAuthorizeToProfile
import constants.BanksIdConstant
import constants.BanksJSONConstant
import constants.PhoneConstant
import org.junit.Assert

/*
Запрос на получение счетов клиента

Проверяет счет:

1. В Геобанк 2 счета
2. В Гарант-Инвест 1 счет
3. В Абсолют 1 счет
4. В банке, еще не добавленном в справочник, 1 счет

5. ФИО

 */

object SbpCustomerAccountAsserts {
    fun verify() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

        val fetchedCustomerAccount = ApiSbpCustomerAccount.fetch()

        // Asserts
        verifyBanksAndAccounts(fetchedCustomerAccount = fetchedCustomerAccount)
        verifyName(fetchedCustomerAccount = fetchedCustomerAccount)
    }

    private fun verifyName(fetchedCustomerAccount: CustomerAccountModel) {
        val expectedName = "Давыдова Ирина Александровна"
        val fetchedName = fetchedCustomerAccount.name

        when (fetchedName == expectedName) {
            true -> {
                println("Success: the names are the same")
                Assert.assertTrue(true)
            }
            false -> {
                println("Error: fetched name $fetchedName does not match the expected name $expectedName")
                Assert.assertTrue(false)
            }
        }
    }

    private fun verifyBanksAndAccounts(fetchedCustomerAccount: CustomerAccountModel) {
        val expectedAccountBanksCount = 4
        val expectedGeobank209AccountsCount = 2
        val expectedGarant112AccountsCount = 1
        val expectedAbsolut47AccountsCount = 1
        val expectedNotExist666AccountsCount = 1

        for (index in 0 until expectedAccountBanksCount) {
            val fetchedCustomerAccountBanksCount = fetchedCustomerAccount.banks.count()
            if (fetchedCustomerAccountBanksCount != expectedAccountBanksCount) {
                println("Error: fetched banks count $fetchedCustomerAccountBanksCount does not match the expected banks count $expectedAccountBanksCount")
                Assert.assertTrue(false)
            }

            when (fetchedCustomerAccount.banks[index].id) {
                BanksIdConstant.geobank100000000209 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    when (fetchedAccountCount == expectedGeobank209AccountsCount) {
                        true -> {
                            printSuccessMessage(bankId = BanksIdConstant.geobank100000000209)
                            Assert.assertTrue(true)
                        }
                        false -> {
                            printErrorMessage(bankId = BanksIdConstant.geobank100000000209)
                            Assert.assertTrue(false)
                        }
                    }
                }
                BanksIdConstant.garantinvest100000000112 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    when (fetchedAccountCount == expectedGarant112AccountsCount) {
                        true -> {
                            printSuccessMessage(bankId = BanksIdConstant.garantinvest100000000112)
                            Assert.assertTrue(true)
                        }
                        false -> {
                            printErrorMessage(bankId = BanksIdConstant.garantinvest100000000112)
                            Assert.assertTrue(false)
                        }
                    }
                }
                BanksIdConstant.absolutbank100000000047 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    when (fetchedAccountCount == expectedAbsolut47AccountsCount) {
                        true -> {
                            printSuccessMessage(bankId = BanksIdConstant.absolutbank100000000047)
                            Assert.assertTrue(true)
                        }
                        false -> {
                            printErrorMessage(bankId = BanksIdConstant.absolutbank100000000047)
                            Assert.assertTrue(false)
                        }
                    }
                }
                BanksIdConstant.notExist100000000666 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    when (fetchedAccountCount == expectedNotExist666AccountsCount) {
                        true -> {
                            println("Success: not exist bank are the same")
                            Assert.assertTrue(true)
                        }
                        false -> {
                            printErrorMessage(bankId = "not exist")
                            Assert.assertTrue(false)
                        }
                    }
                }
                else -> {
                    println("Error: bank ${fetchedCustomerAccount.banks[index].id} not found")
                    Assert.assertTrue(false)
                }
            }
        }
    }

    private fun printSuccessMessage(bankId: String) {
        val bankModel = BanksJSONConstant.getBanksFromLocalFile()
        val model = bankModel.find { it.id == bankId }
        if (model != null) println("Success: ${model.name} bank are the same")
        else {
            println("Error: bank $bankId not found in local file")
            Assert.assertTrue(false)
        }
    }

    private fun printErrorMessage(bankId: String) {
        println("Error: bank $bankId bank does not match")
    }
}