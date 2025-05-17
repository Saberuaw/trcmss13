//Ordnance Technician
/datum/job/logistics/otech
	title = JOB_ORDNANCE_TECH
	total_positions = 3
	spawn_positions = 3
	allow_additional = 1
	scaled = 1
	supervisors = "Başmühendis"
	selection_class = "job_ot"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/ordn
	entry_message_body = "Görevin Orbital bombardıman topu da dahil olmak üzere USCM silahlarının, mühimmatının ve teçhizatının bakımını yapmaktır."

/datum/job/logistics/otech/set_spawn_positions(count)
	spawn_positions = ot_slot_formula(count)

/datum/job/logistics/otech/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = ot_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/logistics/otech, list(
	JOB_ENGINEER_ROLES = 1 HOURS
))

/obj/effect/landmark/start/otech
	name = JOB_ORDNANCE_TECH
	icon_state = "ot_spawn"
	job = /datum/job/logistics/otech
