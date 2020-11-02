package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import constants.BankConstant
import khttp.post

class ApiSbpCustomerDefaultBankConfirmModification {

    fun fetchDefaultBankConfirmModification(sms: String) {
        val response = post(ApiURLConstants.sbpCustomerDefaultBankConfirmModification, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"), data = mapOf("bankId" to BankConstant.transstroybank100000000197, "controlValue" to ProfileObject.controlValue, "fpMessageId" to ProfileObject.fpMessageId, "otp" to sms))

        val json = response.text
        println("\n${json}\n")

        println("\nЗавершение установки банка по умолчанию. Статус код: " + response.statusCode + "\n")
    }
}