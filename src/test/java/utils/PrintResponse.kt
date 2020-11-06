package utils

import khttp.responses.Response

object PrintResponse {
    fun print(response: Response) {
        println("status code: ${response.statusCode}")
        println(response.text)
    }
}