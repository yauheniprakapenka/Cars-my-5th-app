    package sbp.commission

    import sbp.commission.Models.CommissionDTO
    import sbp.commission.Models.CommissionRuleDTO
    import sbp.commission.Models.CommissionRulesDTO
    import sbp.commission.Models.LimitDTO
    import org.junit.Test
    import java.math.BigDecimal

    // totalSum - Переведено ранее пользователем
    // Общая сумма перевода за календарный период в минорных единицах валюты.

    // totalSumLimit - Осталось лимита totalSumLimit
    // Пороговая граница общей суммы перевода в минорных единицах валюты, для которой вычисляется отдельная комиссия. Граница указывается включительно.
    // Значение должно быть обязательно указана ровно 1 раз в запросе. В этом случае указанные в объекте атрибуты относятся к диапазону от 0 до порогового значения (включительно ).
    // Если значение не указано, то такие объекты относятся к диапазону от порогового значения (не включительно) до 9999999999.

    class CalculateCommissionSBPv2() {

        var calculateComissionCount = 0 // добавил

        @Test
        fun cacl() {
    //        fun cacl(args: Array<String>) {rangeRules.keys.sorted().forEach
            val amount = 99999_00
            val totalSum = 926_00L
            val totalSumLimit = 100_000_00L

            val commissionRules = CommissionRulesDTO(
                    totalSum = totalSum,
                    limit = LimitDTO(maxAmount = 600_000_00L),

                    rules = listOf<CommissionRuleDTO>(
                            CommissionRuleDTO(
                                    totalSumLimit = totalSumLimit,
                                    minAmount = 0,
                                    maxAmount = 0,
                                    commission = CommissionDTO(
                                            percent = 0.0,
                                            min = 0,
                                            max = 0,
                                            fixed = 0
                                    )
                            ),
                            CommissionRuleDTO(
                                    minAmount = 1,
                                    maxAmount = 300_000_00,
                                    commission = CommissionDTO(
                                            percent = 0.5,
                                            min = 0,
                                            max = 1500_00,
                                            fixed = 0
                                    )
                            )
                    )
            )

            print("""
            ************************************************
            ******************* Условие ********************
            ************************************************
            """)

            print("\nПередевено: ${totalSum} / ${totalSumLimit}\n")
            print("Пользователь ввел сумму: ${amount}\n")

            print("""
            ************************************************
            *** Сгруппировать правила по total sum limit ***
            ************************************************
            """)

            val rangeRules = commissionRules.groupedRulesByTotalSumLimit()
            print("\nrangeRules:\n${rangeRules}\n")

            var commission = 0L
            var previousPorog = commissionRules.totalSum // totalSum - Переведено ранее пользователем
            var calculatedAmount = 0L

            rangeRules.keys.sorted().forEach {
                print("""
                ************************************************
                ***************** Range Rules ******************
                ************************************************
                """)

                print("\n----- start rangeRules.keys.sorted().forEach -----\n")

                val amountForRange = Math.max(Math.min(amount - calculatedAmount, it - previousPorog), 0L)
                print("Находим сумму для правила:\n")
                print("amountForRange = Math.max(Math.min(amount ${amount} - calculatedAmount ${calculatedAmount}, totalSumLimit ${it} - previousPorog ${previousPorog}), 0L) = ${amountForRange}\n")

                commission += calculateComission(amount = amountForRange, rules = rangeRules.get(it))

                print("Комиссия для правила: ${commission}\n")
                calculatedAmount += amountForRange
                print("Прибавляем посчитанную сумму calculatedAmount: ${calculatedAmount}\n")
                previousPorog = it
                print("previousPorog: ${previousPorog}\n")

                print("----- end rangeRules.keys.sorted().forEach -----\n\n")
            }

            println("control check commission: ${commission} руб.\n")
        }

        fun CommissionRulesDTO.groupedRulesByTotalSumLimit(): Map<Long, List<CommissionRuleDTO>> {
            return mutableMapOf<Long, List<CommissionRuleDTO>>().apply {// porogSum - List of Rules
                rules.forEach {
                    print("\n----- start grouped Rules By Total SumLimit -----\n")

                    val key = it.totalSumLimit ?: Long.MAX_VALUE
                    print("key = totalSumLimit ${it.totalSumLimit} ?: MAX_VALUE ${Long.MAX_VALUE} = ${key}\n")

                    put(key, (get(key) ?: listOf<CommissionRuleDTO>()).plus(it))
                    print("key ${key}, (get(key ${key}) ?: listOf<CommissionRuleDTO>()).plus(it)) ${put(key, (get(key) ?: listOf<CommissionRuleDTO>()).plus(it))}\n")

                    print("----- end grouped Rules By Total SumLimit -----\n")
                }
            }
        }

        fun calculateComission(amount: Long, rules: List<CommissionRuleDTO>?): Long {
            print("\n----- start calculate comission -----\n")

            print("amount: ${amount}\n")
            print("Используем правило: ${rules}\n")

            val rule = rules
                    ?.find { amount in it.minAmount..it.maxAmount }
                    ?.commission?.calculateCommissionFromAmount(amount)
                    ?: 0L

            if (rules?.find { amount in it.minAmount..it.maxAmount } == null) {
                print("amount ${amount} не удовлетворяет minAmount и maxAmount, поэтому делаем комиссию по умолчанию 0\n")
            }

            print("----- end calculate Comission -----\n\n")
            return rule
        }

        private fun CommissionDTO.calculateCommissionFromAmount(amount: Long): Long {
            if (amount == 0L) {
                print("\nПользователь ввел сумму ноль, поэтому делаем комиссию по умолчанию 0\n")
                return 0L
            }

            print("\n----- start calculate Commission From Amount -----\n")
            print("amount ${amount} удовлетворяет minAmount и maxAmount\n")

            var commission = (BigDecimal(amount).multiply(BigDecimal(percent).divide(BigDecimal(100.0)))).toLong()
            print("Находим процент от суммы: ${amount} * (${percent} / 100) = ${(commission)}\n")
            val beforeCommission = commission // сам добавил
            commission =
                    if (commission < min) min
                    else if (commission > max) max
                    else commission
            print("Корректируем процент от суммы через диапазон min и max: ${min} < ${beforeCommission} < ${max} = ${commission}\n")
            print("Прибавляем фиксированную сумму к проценту: ${commission} + ${fixed} = ${commission + fixed}\n")
            print("Комиссия: ${commission + fixed}\n")
            print("----- end calculate Commission From Amount -----\n")
            return commission + fixed
        }
    }