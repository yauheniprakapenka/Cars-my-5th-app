package assertMethods

import api.apiRequests.ApiSbpBank
import api.apiRequests.ApiSbpCustomerDefaultAccountSet
import api.apiRequests.CustomerAccountModel
import constants.BankConstant
import constants.BanksConstant
import org.junit.Assert

object AssertMethods {
    fun checkName(fetchedAccount: CustomerAccountModel) {
        val name = "Давыдова Ирина Александровна"
        Assert.assertTrue(fetchedAccount.name == name)
    }

    fun checkBankAccounts(fetchedAccount: CustomerAccountModel) {
        val accountBanksCount = 4
        val geobank100000000209AccountsCount = 2
        val garant100000000112AccountsCount = 1
        val absolut100000000047AccountsCount = 1
        val notExist100000000666AccountsCount = 1

        for (index in 0 until accountBanksCount) {
            when (fetchedAccount.banks[index].id) {
                BankConstant.geobank100000000209 -> {
                    val fetchedAccountCount = fetchedAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == geobank100000000209AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BankConstant.garantinvest100000000112 -> {
                    val fetchedAccountCount = fetchedAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == garant100000000112AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BankConstant.absolutbank100000000047 -> {
                    val fetchedAccountCount = fetchedAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == absolut100000000047AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BankConstant.notExist100000000666 -> {
                    val fetchedAccountCount = fetchedAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == notExist100000000666AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                else -> {
                    print("Банк ${fetchedAccount.banks[index].id} не найден\n")
                    Assert.assertTrue(false)
                }
            }
        }
    }

    fun setDefaultAccountSuccess() {
        val apiSbpCustomerDefaultAccountSet = ApiSbpCustomerDefaultAccountSet()
        val statusCode = apiSbpCustomerDefaultAccountSet.fetchDefaultAccountSet()
        Assert.assertTrue(statusCode == 200)
    }

    fun checkBanksReference() {
        val expectedBanksConstant = BanksConstant.getBanks()
        val expectedBanksConstantCount = expectedBanksConstant.count()

        val expectedBanks = mutableListOf<String>()
        for (index in 0 until expectedBanksConstantCount) {
            expectedBanks += expectedBanksConstant[index].name
        }

        val apiSbpBank = ApiSbpBank()
        val fetchedBanks = apiSbpBank.fetchBank()
        val fetchedBanksCount = fetchedBanks.count()

        val expectedBanksCount = 193
        Assert.assertTrue(expectedBanksConstantCount == expectedBanksCount)
        Assert.assertTrue(fetchedBanksCount == expectedBanksCount)

        for (index in 0 until fetchedBanks.count()) {
            if (expectedBanks.contains(fetchedBanks[index].name)) {
                Assert.assertTrue(true)
            } else {
                print("Полученный ${fetchedBanks[index].name} отсутствует в константе банков")
                Assert.assertTrue(false)
            }
        }
    }
}