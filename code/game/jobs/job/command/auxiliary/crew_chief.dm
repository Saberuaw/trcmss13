/datum/job/command/crew_chief
	title = JOB_DROPSHIP_CREW_CHIEF
	total_positions = 2
	spawn_positions = 2
	allow_additional = TRUE
	scaled = TRUE
	supervisors = "Pilotlar"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/dcc
	entry_message_body = "Görevin uçak içerisindeki düzeni sağlamak ve pilota uçağın bakımında yardımcı olmaktır Yetkin sadece görevli olduğun uçak içerisindedir."

AddTimelock(/datum/job/command/crew_chief, list(
	JOB_SQUAD_ROLES = 5 HOURS,
	JOB_MEDIC_ROLES = 1 HOURS
))

/obj/effect/landmark/start/crew_chief
	name = JOB_DROPSHIP_CREW_CHIEF
	icon_state = "dcc_spawn"
	job = /datum/job/command/crew_chief
