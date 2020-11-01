package sbp.commission.Models

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