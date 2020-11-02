package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import com.google.gson.Gson
import khttp.get
import org.junit.Assert

data class CustomerAccountModel(
        val name: String,
        val banks: Array<BanksModel>
)

data class BanksModel(
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

class ApiSbpCustomerAccount {
    fun fetchCustomerAccount(): CustomerAccountModel {
        val response = get(ApiURLConstants.sbpCustomerAccount, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n\n${json}\n")

        val gson = Gson()
        val account = gson.fromJson(json, CustomerAccountModel::class.java)

        return account
    }
}