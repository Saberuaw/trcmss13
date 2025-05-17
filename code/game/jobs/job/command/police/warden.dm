//Warden
/datum/job/command/warden
	title = JOB_WARDEN
	selection_class = "job_mp"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	supervisors = "İnzibat Şefi"
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_police/warden
	entry_message_body = "Diğer rollere göre daha fazla gücünüz ve sorumluluğunuz olduğundan genel oyuncu topluluğuna göre daha yüksek bir standarda tabi tutulursun. Sadece sunucu kurallarına değil, Denizci Yasası'na da uyman gerekmektedir. Bunların ihlali rol veya sunucu banı ile sonuçlanabilir. Görevin gemide sükuneti ve istikrarı korumak. Buna ek olarak komuta kademesi de dahil olmak üzere yüksek rütbeli personelin güvenliğini sağlamakla görevlisin. Ayrıca güvenlik kayıtları ve mahkumları ile ilgilenmek de senin görevin. Mürettebatı güvende tut!"
	var/mob/living/carbon/human/active_warden

/datum/job/command/warden/generate_entry_conditions(mob/living/warden, whitelist_status)
	. = ..()
	active_warden = warden
	RegisterSignal(warden, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_warden))

/datum/job/command/warden/proc/cleanup_active_warden(mob/warden)
	SIGNAL_HANDLER
	active_warden = null

AddTimelock(/datum/job/command/warden, list(
	JOB_POLICE_ROLES = 10 HOURS
))

/obj/effect/landmark/start/warden
	name = JOB_WARDEN
	icon_state = "mw_spawn"
	job = /datum/job/command/warden
