package api.apiRequests

import `object`.ProfileObject
import com.google.gson.Gson
import api.apiConfigure.ApiURLConstants
import constants.SBPConstants
import khttp.post
import org.junit.Assert

private data class ApiDefaultBankStartModificationModel(
        val fpMessageId: String = "",
        val controlValue: String = ""
)

class ApiSbpCustomerDefaultBankStartModification {

    fun defaultBankStartModification() {
        val response = post(ApiURLConstants.sbpCustomerDefaultBankStartModification, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("bankId" to SBPConstants.bankId10197))

        val json = response.text
        println("\n${json}\n")

        Assert.assertTrue(response.statusCode == 200)

        val gson = Gson()
        val apiDefaultBankStartModificationModel = gson.fromJson(json, ApiDefaultBankStartModificationModel::class.java)

        ProfileObject.fpMessageId = apiDefaultBankStartModificationModel.fpMessageId
        ProfileObject.controlValue = apiDefaultBankStartModificationModel.controlValue

        println("\n" + ProfileObject.profileObject)
    }
}