package asserts

import api.apiRequests.ApiSbpCustomerAccount
import api.apiRequests.CustomerAccountModel
import api.apiScript.ApiScriptAuthorizeToProfile
import constants.BanksIdConstant
import constants.PhoneConstant
import org.junit.Assert

object SbpCustomerAccountAsserts {
    fun verify() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.garantInvest_7_000_901_01_12)

        val fetchedCustomerAccount = ApiSbpCustomerAccount.fetch()

        // Asserts
        checkBanksAndAccounts(fetchedCustomerAccount = fetchedCustomerAccount)
        checkName(fetchedCustomerAccount = fetchedCustomerAccount)
    }

    private fun checkName(fetchedCustomerAccount: CustomerAccountModel) {
        val name = "Давыдова Ирина Александровна"
        Assert.assertTrue(fetchedCustomerAccount.name == name)
    }

    private fun checkBanksAndAccounts(fetchedCustomerAccount: CustomerAccountModel) {
        val expectedAccountBanksCount = 4
        val expectedGeobank209AccountsCount = 2
        val expectedGarant112AccountsCount = 1
        val expectedAbsolut47AccountsCount = 1
        val expectedNotExist666AccountsCount = 1

        for (index in 0 until expectedAccountBanksCount) {
            if (fetchedCustomerAccount.banks.count() != expectedAccountBanksCount) {
                println("Error: fetched banks count != expected banks count")
                Assert.assertTrue(false)
            }

            when (fetchedCustomerAccount.banks[index].id) {
                BanksIdConstant.geobank100000000209 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == expectedGeobank209AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BanksIdConstant.garantinvest100000000112 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == expectedGarant112AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BanksIdConstant.absolutbank100000000047 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == expectedAbsolut47AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                BanksIdConstant.notExist100000000666 -> {
                    val fetchedAccountCount = fetchedCustomerAccount.banks[index].accounts.count()
                    if (fetchedAccountCount == expectedNotExist666AccountsCount) Assert.assertTrue(true) else Assert.assertTrue(false)
                }
                else -> {
                    print("Банк ${fetchedCustomerAccount.banks[index].id} не найден\n")
                    Assert.assertTrue(false)
                }
            }
        }
    }
}