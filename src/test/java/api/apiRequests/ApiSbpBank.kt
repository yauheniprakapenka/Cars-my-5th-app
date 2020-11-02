package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import com.google.gson.Gson
import khttp.get

data class BanksModel(
        val id: String,
        val name: String,
        val alias: String
)

class ApiSbpBank {
    fun fetchBank(): Array<BanksModel> {
        val headers = mapOf(
                "X-IV-Authorization" to "Session ${ProfileObject.sessionId}"
        )
        val response = get(ApiURLConstants.sbpBank, headers = headers)

        val json = response.text
        val gson = Gson()
        val banksModel = gson.fromJson(json, Array<BanksModel>::class.java)

        return banksModel
    }
}
