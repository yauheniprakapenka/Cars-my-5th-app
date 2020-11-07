package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import com.google.gson.Gson
import khttp.get
import org.junit.Assert
import utils.PrintResponse

data class BanksModel(
        val id: String,
        val name: String,
        val alias: String?
)

object ApiSbpBank {
    fun fetchBank(): Array<BanksModel> {
        val headers = mapOf(
                "X-IV-Authorization" to "Session ${ProfileObject.sessionId}"
        )
        val response = get(ApiURLConstants.sbpBank, headers = headers)
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
        val banksModel = gson.fromJson(json, Array<BanksModel>::class.java)

        return banksModel
    }
}
