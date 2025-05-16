//CMO
/datum/job/civilian/professor
	title = JOB_CMO
	total_positions = 1
	spawn_positions = 1
	supervisors = "the acting commanding officer"
	selection_class = "job_cmo"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/cmo
	entry_message_body = "USCM'ye bağlı bir subaysın. Medbay ve Araştırma departmanlarından sorumlusun, emirlerin ancak İK ve BK tarafından geçersiz kılınabilir. Genel olarak medikal personelinden, ameliyatlardan, stimulantlardan, kısaca piyadelerin sağlığından sorumlusun."
	var/mob/living/carbon/human/active_cmo

/datum/job/civilian/professor/generate_entry_conditions(mob/living/cmo, whitelist_status)
	. = ..()
	active_cmo = cmo
	RegisterSignal(cmo, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_cmo))

/datum/job/civilian/professor/proc/cleanup_active_cmo(mob/cmo)
	SIGNAL_HANDLER
	active_cmo = null

/datum/job/civilian/professor/get_active_player_on_job()
	return active_cmo

AddTimelock(/datum/job/civilian/professor, list(
	JOB_DOCTOR_ROLES = 10 HOURS,
	JOB_MEDIC_ROLES = 10 HOURS,
	JOB_RESEARCH_ROLES = 5 HOURS,
))

/obj/effect/landmark/start/professor
	name = JOB_CMO
	icon_state = "cmo_spawn"
	job = /datum/job/civilian/professor
