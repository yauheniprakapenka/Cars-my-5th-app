package api.apiRequests

import `object`.ProfileObject
import com.google.gson.Gson
import api.apiConfigure.ApiURLConstants
import constants.SBPConstants
import khttp.get
import org.junit.Assert

private data class ApiSbpFindRecipientModel(
        val fpMessageId: String = "",
        val controlValue: String = ""
)

class ApiSbpFindRecipient {
    fun sbpFindRecipient(recipient: String) {
        val response = get(ApiURLConstants.sbpFindRecipient + "?bankId=${SBPConstants.bankId10197}&msisdn=${recipient}", headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"))
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")

        val gson = Gson()
        val tokenModel = gson.fromJson(json, ApiSbpFindRecipientModel::class.java)

        ProfileObject.fpMessageId = tokenModel.fpMessageId
        ProfileObject.controlValue = tokenModel.controlValue
    }
}