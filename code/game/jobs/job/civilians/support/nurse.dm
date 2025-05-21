/datum/job/civilian/nurse
	title = JOB_NURSE
	total_positions = 3
	spawn_positions = 3
	supervisors = "Başhekim"
	selection_class = "job_doctor"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/nurse
	entry_message_body = "Askerleri sağlıklı ve güçlü tutmakla görevlisiniz. Ayrıca ilaç ve tedavi konusunda bir uzmansınız ve küçük cerrahi prosedürler uygulayabilirsiniz. Doktorlara ve yaralı askerlere yardımcı olmaya çalışın."

/obj/effect/landmark/start/nurse
	name = JOB_NURSE
	icon_state = "nur_spawn"
	job = /datum/job/civilian/nurse

AddTimelock(/datum/job/civilian/nurse, list(
	JOB_HUMAN_ROLES = 1 HOURS
))
