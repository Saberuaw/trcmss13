/datum/job/logistics/engineering
	title = JOB_CHIEF_ENGINEER
	selection_class = "job_ce"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/chief_engineer
	entry_message_body = "İşin geminin ve departmanının bakımını yapmak ve teknisyenlerini kontrol altında tutmak. Mühendislikten, geminin elektriğinden, özel mühimmatların hazırlanmasından ve orbital bombardıman topundan sen sorumlusun."
	var/mob/living/carbon/human/active_chief_engineer

/datum/job/logistics/engineering/generate_entry_conditions(mob/living/chief_engineer, whitelist_status)
	. = ..()
	active_chief_engineer = chief_engineer
	RegisterSignal(chief_engineer, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_chief_engineer))

/datum/job/logistics/engineering/proc/cleanup_active_chief_engineer(mob/chief_engineer)
	SIGNAL_HANDLER
	active_chief_engineer = null

/datum/job/logistics/engineering/get_active_player_on_job()
	return active_chief_engineer

AddTimelock(/datum/job/logistics/engineering, list(
	JOB_ENGINEER_ROLES = 10 HOURS,
))

/obj/effect/landmark/start/engineering
	name = JOB_CHIEF_ENGINEER
	icon_state = "ce_spawn"
	job = /datum/job/logistics/engineering
