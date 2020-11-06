package utils

import java.io.File
import java.io.InputStream
import java.nio.charset.Charset

object MakeStringFromLocalFile {
    fun make(fileName: String): String {
        val file = File(fileName)
        val inputStream: InputStream = file.inputStream()
        val content = inputStream.readBytes().toString(Charset.defaultCharset())
        return content
    }
}