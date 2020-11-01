package sbp.Callback

import khttp.post
import org.junit.Test
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

class RepeatCallback {

//    private val baseUrl = "https://rbc-test.intervale.ru" - старый вариант
    private val baseUrl = "https://rbc-test.intervale.ru/RU_SBP_ATLAS"

    private val headerData = mapOf(
            "Content-Type" to "application/json; charset=UTF-8"
    )

    private val bodyData = "{\n" +
            "  \"callback\": \"notify\",\n" +
            "  \"order\": {\n" +
            "    \"id\": \"df145931-f7c3-7281-913a-f76800a39301\",\n" +
            "    \"status\": \"NEW\"\n" +
            "  },\n" +
            "  \"balance\": 4800000,\n" +
            "  \"checksum\": \"w8NAbdBfTfqckWefA2HxM3Xp9F+xMEi9ddZgvyVzomA7/aSRw0vuYrCDLOHQdFPqQXS+7ZWkRnT+h9IySMpjLSGTv2Hs0HHk+Mwn5j9rWv5dFMP5++VVBRVMcRCY3Aq2GCBf9o8QUKTTeLLyyECfnA==\",\n" +
            "  \"notify_date\": \"2020-08-05T11:43:59Z\"\n" +
            "}"

    @Test
    fun repeatCallback() {

        var sleep: Long = 1000

        for (i in 0..1) {
            Thread.sleep(sleep)

            val current = LocalDateTime.now()
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
            val formatted = current.format(formatter)

            val response = post(baseUrl, headers = headerData, data = bodyData)
            val json = response.statusCode

            println("[$formatted] Попытка $i. Cтатус-код: $json")
//            sleep += 50000
        }
    }

}