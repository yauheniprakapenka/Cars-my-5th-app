import org.junit.Test
import java.math.BigDecimal

data class CommissionRulesDTO(
        val limit: LimitDTO,
        val totalSum: Long,
        val bankId: String? = null,
        val account: String? = null,
        val rules: List<CommissionRuleDTO>
)

data class CommissionRuleDTO(
        val totalSumLimit: Long? = null,
        val minAmount: Long,
        val maxAmount: Long,
        val commission: CommissionDTO
)

data class CommissionDTO(
        val fixed: Long,
        val percent: Double,
        val min: Long,
        val max: Long
)

data class LimitDTO(
        val maxAmount: Long
)

class CalculateComissionSBPv2() {

    @Test
    fun cacl() {
//        fun cacl(args: Array<String>) {
        val amount = 33000_00

        val comissionRules = CommissionRulesDTO(
                totalSum = 50_000_00,//50_000_00L,
                limit = LimitDTO(maxAmount = 500_000_00L),

                rules = listOf<CommissionRuleDTO>(
                        CommissionRuleDTO(
                                totalSumLimit = 100_000_00L,
                                minAmount = 0,
                                maxAmount = 50_000_00,//100_000_00L,
                                commission = CommissionDTO(
                                        percent = 5.0,//0.0,
                                        min = 111_00,//0,
                                        max = 222_00,
                                        fixed = 0
                                )
                        )
                        ,
                        CommissionRuleDTO(
                                totalSumLimit = 200_000_00L,
                                minAmount = 100_01L,
                                maxAmount = 500_000_00L,
                                commission = CommissionDTO(
                                        percent = 10.0,
                                        min = 444_00,
                                        max = 555_00,
                                        fixed = 66_00
                                )
                        )
                        ,
                        CommissionRuleDTO(
                                minAmount = 0,
                                maxAmount = 100_000_00L,
                                commission = CommissionDTO(
                                        percent = 15.0,
                                        min = 777_00,
                                        max = 888_00,
                                        fixed = 99_00
                                )
                        )
                )
        )

        val rangeRules = comissionRules.groupedRulesByTotalSumLimit()

        var commission = 0L
        var previousPorog = comissionRules.totalSum
        var calculatedAmount = 0L
        rangeRules.keys.sorted().forEach {
            val amountForRange = Math.max(Math.min(amount - calculatedAmount, it - previousPorog), 0L)
            commission += calculateComission(
                    amount = amountForRange ,
                    rules = rangeRules.get(it)
            )
            calculatedAmount += amountForRange
            previousPorog = it
        }

        println("commission = ${commission}")
    }

    fun CommissionRulesDTO.groupedRulesByTotalSumLimit(): Map<Long, List<CommissionRuleDTO>> {
        return mutableMapOf<Long, List<CommissionRuleDTO>>().apply {// porogSum - List of Rules
            rules.forEach {
                val key = it.totalSumLimit ?: Long.MAX_VALUE
                put(key, (get(key) ?: listOf<CommissionRuleDTO>()).plus(it))
            }
        }
    }

    fun calculateComission(amount: Long, rules: List<CommissionRuleDTO>?): Long {
        return rules
                ?.find { amount in it.minAmount..it.maxAmount }
                ?.commission?.calculateCommissionFromAmount(amount)
                ?: 0L
    }

    private fun CommissionDTO.calculateCommissionFromAmount(amount: Long): Long {
        if (amount == 0L)
            return 0L
        var commission = (BigDecimal(amount).multiply(BigDecimal(percent).divide(BigDecimal(100.0)))).toLong()
        commission =
                if (commission < min) min
                else if (commission > max) max
                else commission
        return commission + fixed
    }
}
