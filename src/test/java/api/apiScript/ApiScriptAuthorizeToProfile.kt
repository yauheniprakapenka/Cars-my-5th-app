package api.apiScript

import `object`.ProfileObject
import api.apiRequests.*
import io.qameta.allure.Step

class ApiScriptAuthorizeToProfile {

    private val profileRegistrationStart = ApiProfileRegistrationStart()
    private val profileRegistrationVerifyotp = ApiProfileRegistrationVerifyotp()
    private val profileRegistrationConfirm = ApiProfileRegistrationConfirm()
    private val sessionStart2fa = ApiSessionStart2fa()
    private val sessionConfirm2fa = ApiSessionConfirm2fa()

    // MARK: - Methods

    @Step("api_script_authorize_to_profile")
    fun authorizeToProfile(profile: String) {
        ProfileObject.profile = profile

        when (val statusCode = profileRegistrationStart.api_profile_registration_start(ProfileObject.profile)) {
            200 -> api_start_new_profile()
            400 -> api_profile_already_registered()
            else -> {
                error("$statusCode статус не обрабатывается")
            }
        }
    }

    @Step("api_start_new_profile")
    private fun api_start_new_profile() {
        profileRegistrationVerifyotp.api_profile_registration_verify_otp(ProfileObject.profile)
        profileRegistrationConfirm.api_profile_registration_confirm(ProfileObject.profile)
    }

    @Step("api_profile_already_registered")
    private fun api_profile_already_registered() {
        sessionStart2fa.apiSessionStart2fa(ProfileObject.profile)
        sessionConfirm2fa.apiSessionConfirm2fa(ProfileObject.profile)
    }

}