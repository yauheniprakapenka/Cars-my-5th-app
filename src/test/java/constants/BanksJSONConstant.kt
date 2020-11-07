package constants

import api.apiRequests.BanksModel
import com.google.gson.Gson
import utils.MakeStringFromLocalFile

object BanksJSONConstant {
    val filePath = "src/test/java/constants/localFiles/ApiSbpBankResponse.json"
    val banksString = MakeStringFromLocalFile.make(fileName = filePath)

    fun getBanksFromLocalFile(): Array<BanksModel> {
        val gson = Gson()
        val model = gson.fromJson(banksString, Array<BanksModel>::class.java)
        return model
    }
}