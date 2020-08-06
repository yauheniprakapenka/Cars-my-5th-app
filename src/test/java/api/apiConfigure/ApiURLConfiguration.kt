package api.apiConfigure

import enums.OSEnum

// Указать портал
val app = OSEnum.ANDROID

class ApiURLConfiguration {
    val apiURL = configApiURL()

    private fun configApiURL(): String {
        val ftestURL = "https://openapi-entry-ftest.intervale.ru/api/v4"
        var portal = ""

        when(app) {
            OSEnum.ANDROID -> portal = "/SBPATLASANDROID6EF36928069F3F740"
            OSEnum.IOS     -> portal = "/SBPATLASIOSAAA1F86DA30C32F9D847B"
            else -> error("\nНе добавлен портал\n")
        }

        return ftestURL + portal
    }
}