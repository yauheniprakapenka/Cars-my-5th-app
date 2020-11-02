package api.apiConfigure

import enums.OSEnum

// Указываем ОС, чтобы сформировать нужный портал
val app = OSEnum.ANDROID

class ApiURLConfiguration {
    val apiURL = configApiURL()

    private fun configApiURL(): String {
        val ftestURL = "https://openapi-entry-ftest.intervale.ru/api/v4"

        val portal: String = when(app) {
            OSEnum.ANDROID -> "/SBPATLASANDROID6EF36928069F3F740"
            OSEnum.IOS     -> "/SBPATLASIOSAAA1F86DA30C32F9D847B"
            else -> error("\nНе добавлен портал в конфигурацию проекта\n")
        }

        return ftestURL + portal
    }
}