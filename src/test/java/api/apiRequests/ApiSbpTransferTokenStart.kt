package api.apiRequests

import `object`.ProfileObject
import api.apiConfigure.ApiURLConstants
import constants.AmountConstant
import constants.BankConstant
import khttp.post
import org.junit.Assert

class ApiSbpTransferTokenStart {

    fun fetchTransferTokenStart(recipientBankId: String, recipientMsisdn: String, amount: String, comment: String?) {

        val payload = if (comment != null) {
            mapOf("sender.bankId" to BankConstant.transstroybank100000000197,
            "sender.account" to BankConstant.account,
            "recipient.bankId" to recipientBankId,
            "recipient.msisdn" to recipientMsisdn,
            "amount" to amount,
            "commission" to AmountConstant.commission50021,
            "currency" to AmountConstant.currencyRUB,
            "fpMessageId" to ProfileObject.fpMessageId,
            "controlValue" to ProfileObject.controlValue,
            "comment" to comment)
        } else {
            mapOf("sender.bankId" to BankConstant.transstroybank100000000197,
                    "sender.account" to BankConstant.account,
                    "recipient.bankId" to recipientBankId,
                    "recipient.msisdn" to recipientMsisdn,
                    "amount" to amount,
                    "commission" to AmountConstant.commission50021,
                    "currency" to AmountConstant.currencyRUB,
                    "fpMessageId" to ProfileObject.fpMessageId,
                    "controlValue" to ProfileObject.controlValue)
        }


        val response = post(ApiURLConstants.sbpTransferTokenStart, headers = mapOf("X-IV-Authorization" to "Session ${ProfileObject.sessionId}"),
                data = payload)
        Assert.assertTrue(response.statusCode == 200)

        val json = response.text
        println("\n${json}\n")
    }
}