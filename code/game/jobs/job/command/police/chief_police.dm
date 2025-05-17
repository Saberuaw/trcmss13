//Chief MP
/datum/job/command/warrant
	title = JOB_CHIEF_POLICE
	selection_class = "job_cmp"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_police/cmp
	entry_message_body = "Görevin gemideki asayişi sağlamak gibi oldukça büyük bir sorumluk olduğundan genel oyuncu topluluğuna göre daha yüksek bir standarda tabi tutulursun. Sadece sunucu kurallarına değil, Denizci Yasası'na da uyman gerekmektedir. Bunların ihlali rol veya sunucu banı ile sonuçlanabilir. İnzibatı yönetiyorsun, takımının gemide sükuneti ve istikrarı korumasını sağlamalısın. Buna ek olarak komuta kademesi de dahil olmak üzere yüksek rütbeli personelin güvenliğini sağlamakla görevlisiniz. Mürettebatı güvende tut!"
	var/mob/living/carbon/human/active_cmp = null;

/datum/job/command/warrant/generate_entry_conditions(mob/living/cmp, whitelist_status)
	. = ..()
	active_cmp = cmp
	RegisterSignal(cmp, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_cmp))

/datum/job/command/warrant/proc/cleanup_active_cmp(mob/cmp)
	SIGNAL_HANDLER
	active_cmp = null

/datum/job/command/warrant/get_active_player_on_job()
	return active_cmp

AddTimelock(/datum/job/command/warrant, list(
	JOB_POLICE_ROLES = 15 HOURS,
	JOB_COMMAND_ROLES = 5 HOURS
))

/obj/effect/landmark/start/warrant
	name = JOB_CHIEF_POLICE
	icon_state = "cmp_spawn"
	job = /datum/job/command/warrant
