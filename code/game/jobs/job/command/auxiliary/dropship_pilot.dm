/datum/job/command/pilot/dropship_pilot
	title = JOB_DROPSHIP_PILOT
	total_positions = 1
	spawn_positions = 1
	allow_additional = TRUE
	scaled = TRUE
	supervisors = "Destek Subayı"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/dp
	entry_message_body = "Görevin geminin nakliye uçağını uçurmak, korumak ve bakımını yapmaktır. Bir subay olmana rağmen yetkin, pilotu olduğun uçağın içiyle sınırlıdır."
	var/mob/living/carbon/human/active_dropship_pilot

/datum/job/command/pilot/dropship_pilot/generate_entry_conditions(mob/living/dropship_pilot, whitelist_status)
	. = ..()
	active_dropship_pilot = dropship_pilot
	RegisterSignal(dropship_pilot, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_dropship_pilot))

/datum/job/command/pilot/dropship_pilot/proc/cleanup_active_dropship_pilot(mob/dropship_pilot)
	SIGNAL_HANDLER
	active_dropship_pilot = null

/datum/job/command/pilot/dropship_pilot/get_active_player_on_job()
	return active_dropship_pilot

// Dropship Roles is both DP, GP and DCC combined to not force people to backtrack
AddTimelock(/datum/job/command/pilot/dropship_pilot, list(
	JOB_DROPSHIP_ROLES = 2 HOURS
))

/obj/effect/landmark/start/pilot/dropship_pilot
	name = JOB_DROPSHIP_PILOT
	icon_state = "dp_spawn"
	job = /datum/job/command/pilot/dropship_pilot
