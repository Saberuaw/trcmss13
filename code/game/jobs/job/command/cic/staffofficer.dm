/datum/job/command/bridge
	title = JOB_SO
	total_positions = 4
	spawn_positions = 4
	allow_additional = 1
	scaled = FALSE
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/so
	entry_message_body = "Göreviniz askerleri izlemek, komutana yardımcı olmak ve üstlerinizi dinlemektir. Lojistikten ikmalini denetlemelisiniz ve gözetleme sisteminden sorumlusunuz. Ayrıca diğer üst rütbeli subaylardan sonra komutayı devralma sırasındasınız."

/datum/job/command/bridge/set_spawn_positions(count)
	spawn_positions = so_slot_formula(count)

/datum/job/command/bridge/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = so_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions


/datum/job/command/bridge/generate_entry_conditions(mob/living/M, whitelist_status)
	. = ..()
	if(!islist(GLOB.marine_leaders[JOB_SO]))
		GLOB.marine_leaders[JOB_SO] = list()
	GLOB.marine_leaders[JOB_SO] += M
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_leader_candidate))

/datum/job/command/bridge/proc/cleanup_leader_candidate(mob/M)
	SIGNAL_HANDLER
	GLOB.marine_leaders[JOB_SO] -= M

AddTimelock(/datum/job/command/bridge, list(
	JOB_SQUAD_LEADER = 1 HOURS,
	JOB_HUMAN_ROLES = 15 HOURS
))

/obj/effect/landmark/start/bridge
	name = JOB_SO
	icon_state = "so_spawn"
	job = /datum/job/command/bridge
