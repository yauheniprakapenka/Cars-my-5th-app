package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import com.google.gson.Gson
import khttp.get
import org.junit.Assert
import utils.PrintResponse

data class CustomerAccountModel(
        val name: String,
        val banks: Array<AccountBanksModel>
)

data class AccountBanksModel(
        val id: String,
        val isDefault: Boolean,
        val accounts: Array<AccountsModel>
)

data class AccountsModel(
        val name: String,
        val number: String,
        val isDefault: Boolean,
        val maskedPan: String,
        val currency: String,
        val balance: BalanceModel
)

data class BalanceModel(
        val value: String,
        val date: String
)

object ApiSbpCustomerAccount {
    fun fetch(): CustomerAccountModel {
        val headers = mapOf(
                "X-IV-Authorization" to "Session ${ProfileObject.sessionId}"
        )
        val response = get(ApiURLConstants.sbpCustomerAccount, headers = headers)
        val json = response.text

        when (response.statusCode) {
            200 -> {
                Assert.assertTrue(true)
            }
            else -> {
                PrintResponse.print(response = response)
                Assert.assertTrue(false)
            }
        }

        val gson = Gson()
        val account = gson.fromJson(json, CustomerAccountModel::class.java)

        return account
    }
}