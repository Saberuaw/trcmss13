/datum/job/command/auxiliary_officer
	title = JOB_AUXILIARY_OFFICER
	total_positions = 1
	spawn_positions = 1
	allow_additional = TRUE
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/auxiliary_officer
	entry_message_body = "Pilotları, istihbarat subaylarını, mühendislik ve lojistik departmanını denetlemek gibi pek çok sorumluluğun var. Bu departmanlara mümkün olduğunca yardımcı olmaya çalış ve komuta personelinin, yardımcı departmanların en yüksek verimlilikte çalıştığından emin olmasını sağla."
	var/mob/living/carbon/human/active_auxiliary_officer

/datum/job/command/auxiliary_officer/generate_entry_conditions(mob/living/auxiliary_officer, whitelist_status)
	. = ..()
	active_auxiliary_officer = auxiliary_officer
	RegisterSignal(auxiliary_officer, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_auxiliary_officer))

/datum/job/command/auxiliary_officer/proc/cleanup_active_auxiliary_officer(mob/auxiliary_officer)
	SIGNAL_HANDLER
	active_auxiliary_officer = null

/datum/job/command/auxiliary_officer/get_active_player_on_job()
	return active_auxiliary_officer

AddTimelock(/datum/job/command/auxiliary_officer, list(
	JOB_SQUAD_ROLES = 5 HOURS,
	JOB_REQUISITION_ROLES = 5 HOURS,
	JOB_ENGINEER_ROLES = 5 HOURS,
	JOB_AUXILIARY_ROLES = 5 HOURS,
))

/obj/effect/landmark/start/auxiliary_officer
	name = JOB_AUXILIARY_OFFICER
	icon_state = "aso_spawn"
	job = /datum/job/command/auxiliary_officer

/datum/timelock/auxiliary
	name = "Auxiliary Roles"

/datum/timelock/auxiliary/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_AUXILIARY_ROLES_LIST
