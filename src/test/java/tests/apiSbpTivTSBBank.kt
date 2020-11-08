package tests

import `object`.ProfileObject
import api.apiRequests.*
import api.apiScript.ApiScriptAuthorizeToProfile
import constants.AmountConstant
import constants.BanksIdConstant
import constants.PhoneConstant
import constants.SMSConstant
import org.junit.Test

/*
        TODO:
        1. Добавить проверки именно в этом файле из требований в экселе
        2. Если для профиля будет два счета, то для 17_199 разные счета поменять, а не один и тот же
        3. Добавить парсинг ошибки 32_186
 */
class apiSbpTivTSBBank {

    // MARK: - 2_216, 6_210 Необходимо добавить клиента Legkova-Roma Svetlana, используя реальный номер телефона
    @Test
    fun isProfile70009010197Exist() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        ApiSbpCustomerAccount.fetch()
        // Ожидание: "name":"Legkova-Roma Svetlana ", два счета, тестируемый банк
    }

    // MARK: - 2_215 Необходимо добавить второго клиента  Иванов Иван Иванович  с номером телефона соответствующим маске тестового сценария 42 Процедуры ТИВ
    // MARK: - 101_116 Попробовать провести перевод на номер телефона 00042{далее по маске}, который присутвует в базе банка и выбираем тестируемый банк (если есть в списке дсотупных).Проверяем, что Участник исключил себя из списка банков, доступных для перевода, или осуществил возможность перевода операции на внутрибанковский перевод
    @Test
    fun isProfileExist70004210197() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_421_0197)
        print(ProfileObject.profileObject)

        ApiSbpCustomerAccount.fetch()

        // Ожидание: в профиле 1 счет с тестируемым банком для Иванов Иван Иванович
    }


    // MARK: - 7_209 Предупредить Участника, что для тестов потребуется УМ Банк, и если Участник не обновлял Справочник Участников - это необходимо сделать пока выполняются первые тесты
    @Test
    fun isUmBankExist() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        ApiSbpBank.fetchBank()

        // "id":"1crt88888886","name":"УМ Банк"
        // id":"1crt88888881","name":"ПИР Банк","alias":"pirbank"
        // "id":"1crt88888882","name":"MKB Банк","alias":"mkb"
        // и тестируемый - "id":"100000000197","name":"Трансстройбанк
    }

    // MARK: - 17_199 Зайти внутрь Раздела установки счета и изменить его на другой.
    @Test
    fun changeAccount() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        ApiSbpCustomerDefaultAccountSet.set()
    }

    // MARK: - 32_186 Необходимо дождаться истечения трех минут с момента получения А22 и продолжить операцию отправив неверный OTP из приложения.
    // MARK: - После получения ошибки из-за "OPKC_LATE_MSG" попытаться продолжить отправку еще одного OTP в рамках существующей операции,
    // MARK: - для проверки того, что  не присылает ся  еще одно А23.
    @Test
    fun bankDefaultTimeout3Minutes() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        val apiSbpCustomerDefaultBankStartModification = ApiSbpCustomerDefaultBankStartModification()
        apiSbpCustomerDefaultBankStartModification.defaultBankStartModification()

        // ожидаем 3 минуты 20 секунд
        Thread.sleep(200000)
        val apiSbpCustomerDefaultBankConfirmModification = ApiSbpCustomerDefaultBankConfirmModification()
        apiSbpCustomerDefaultBankConfirmModification.fetchDefaultBankConfirmModification(SMSConstant.sms123456)

        // ожидание {"error":"OTP_EXPIRED"}
    }

    // MARK: - 32_185 Ввести 6 значный неверный OTP - 3 раза, задержаться на экране сообщения о результате операции.
    @Test
    fun bankDefaultWrong3Times() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        val apiSbpCustomerDefaultBankStartModification = ApiSbpCustomerDefaultBankStartModification()
        apiSbpCustomerDefaultBankStartModification.defaultBankStartModification()

        val apiSbpCustomerDefaultBankConfirmModification = ApiSbpCustomerDefaultBankConfirmModification()
        for (i in 1..3) {
            apiSbpCustomerDefaultBankConfirmModification.fetchDefaultBankConfirmModification(SMSConstant.sms123456)
        }

        // ожидание {"error":"OTP_BLOCKED"}
    }

    // MARK: - 42_174 Ввести 6 значный верный OTP
    @Test
    fun successfulSetDefaultBank() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)
        print(ProfileObject.profileObject)

        val apiSbpCustomerDefaultBankStartModification = ApiSbpCustomerDefaultBankStartModification()
        apiSbpCustomerDefaultBankStartModification.defaultBankStartModification()

        val apiSbpCustomerDefaultBankConfirmModification = ApiSbpCustomerDefaultBankConfirmModification()
        apiSbpCustomerDefaultBankConfirmModification.fetchDefaultBankConfirmModification(SMSConstant.sms888888)

        // ожидание статус код 200
    }

    // MARK: - 144_72 "Попытаться совершить перевод по номеру телефона 00700095{далее по маске} в ПИР Банк - обмен С01-С02  Сумма значения не имеет."
    // MARK: - 145_71 Проверить информирование Отправителя. "Свяжитесь с Получателем средств и уточните реквизиты для зачисления денежных средств" ТБ4 1.2019  Кейс - не найден получатель
    // https://ecpconsole-ftest.intervale.ru/#trx:678120383095874052
    @Test
    fun recipientNotFound() {
       val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
       apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)

       val apiSbpFindRecipient = ApiSbpFindRecipient()
       apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient_7_000_951_0197)

        val apiToken = ApiToken()
        apiToken.fetchToken()

        val apiSbpTransferTokenStart = ApiSbpTransferTokenStart()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient_7_000_951_0197,
                amount = AmountConstant.amount1600698,
                comment = "не найден получатель")

        // Ожидание: "result":{"status":"FAILED","extendedCode":"DECLINED_BY_RECIPIENT_BANK"},
    }

    // MARK: - 153_63 "Совершить перевод по номеру телефона 00700096{далее по маске} в ПИР Банк, дойдя до обмена С01-С02 Сумма значения не имеет."
    // MARK: - 154_62 Проверить информирование Отправителя. РЕКОМЕНДУЕМ: "Повторите операцию позже". Банк Получателя не прислал С04 в течение таймаута Тбп 11-23, через секунду уже готов получить перевод.
    // https://ecpconsole-ftest.intervale.ru/#trx:678120383095874110
    @Test
    fun timeoutAfterContinueButton() {
        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)

        val apiSbpFindRecipient = ApiSbpFindRecipient()
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient_7_000_961_0197)

        val apiToken = ApiToken()
        apiToken.fetchToken()

        val apiSbpTransferTokenStart = ApiSbpTransferTokenStart()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient_7_000_961_0197,
                amount = AmountConstant.amount1600698,
                comment = "Таймаут после нажатия продолжить")

        // Ожидание: от рбс "message":"OPKC_TIMEOUT"
        // ожидание: {"status":"FAILED","extendedCode":"SBP_SYSTEM_ERROR"}
    }

    // MARK: - 98 весь
    @Test
    fun returningFromTheDataControlScreenToChangeDetails() {

        val apiScriptAuthorizeToProfile = ApiScriptAuthorizeToProfile()
        apiScriptAuthorizeToProfile.authorize(PhoneConstant.tsb_7_000_901_0197)

        val apiSbpFindRecipient = ApiSbpFindRecipient()
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient7_000_531_0197)

        val apiToken = ApiToken()
        apiToken.fetchToken()


        println("170_46 Заполнить данные для операции Быстрый платеж, телефон 00700053{далее по маске} УМ Банк, сумма 16006,98 руб.\n")
        println("174_42 Дойти до Экрана контроля уже нередактируемых данных\n")
        val apiSbpTransferTokenStart = ApiSbpTransferTokenStart()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.umBank1crt88888886,
                recipientMsisdn = PhoneConstant.recipient7_000_531_0197,
                amount = AmountConstant.amount1600698,
                comment = null)


        println("175_41 С экрана нередактируемых данных вернуться к изменению Банка.\n")
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient7_000_531_0197)
        apiToken.fetchToken()


        println("176_40 Заменить на ПИР Банк\n")
        println("177_39 Дойти до Экрана контроля уже нередактируемых данных\n")
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient7_000_531_0197,
                amount = AmountConstant.amount1600698,
                comment = null)


        println("179_38 Доходим до экрана нередактируемых данных и возвращаемся чтобы изменить сумму на 16005,98\n")
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient7_000_531_0197)
        apiToken.fetchToken()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient7_000_531_0197,
                amount = AmountConstant.amount1600598,
                comment = null)


        println("179_37 С экрана нередактируемых данных возвращаемся к изменению Назначения платежа\n")
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient7_000_531_0197)
        apiToken.fetchToken()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient7_000_531_0197,
                amount = AmountConstant.amount1600598,
                comment = "Тест 98")


        println("180_37 С экрана нередактируемых данных возвращаемся к изменению Телефона.\n")
        println("180_36 Заменить телефон на 00700098{далее по маске}\n")
        println("181_35 Дойти до Экрана контроля уже нередактируемых данных с реквизитами: ПИР Банк 000700098{далее по маске}  16005,98 \n")
        apiSbpFindRecipient.fetchFindRecipient(recipient = PhoneConstant.recipient7_000_981_0197)
        apiToken.fetchToken()
        apiSbpTransferTokenStart.fetchTransferTokenStart(
                recipientBankId = BanksIdConstant.pirBank1crt88888881,
                recipientMsisdn = PhoneConstant.recipient7_000_981_0197,
                amount = AmountConstant.amount1600598,
                comment = "Тест 98")


        println("183_33 Совершить Перевод\n")
        val apiSbpTransferTokenAccept = ApiSbpTransferTokenAccept()
        apiSbpTransferTokenAccept.fetchTransferTokenAccept()

        println("ввести смс 1111\n")
        val apiSbpTransferTokenAuthenticationConfirm = ApiSbpTransferTokenAuthenticationConfirm()
        apiSbpTransferTokenAuthenticationConfirm.fetchTransferTokenAuthenticationConfirm()

        println("Хардкод ожидание\n")
        Thread.sleep(5000)

        println("Запрос статуса перевода\n")
        val apiSbpTransferToken = ApiSbpTransferToken()
        apiSbpTransferToken.fetchTransferToken()

        // ожидание "result":{"status":"SUCCESS","extendedCode":"OK"}
        // в истории будут переводы в обработке - так как они не были завершены
    }

}