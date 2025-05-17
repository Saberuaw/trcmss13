/datum/job/logistics/maint
	title = JOB_MAINT_TECH
	total_positions = 3
	spawn_positions = 3
	supervisors = "Başmühendis"
	selection_class = "job_ot"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/maint
	entry_message_body = "Görevin orbital bombardıman topu da dahil olmak üzere geminin bakımını yapmaktır. Gemideki esnek rollerden biri olduğunuzdan üstleriniz tarafından herhangi bir görev ile görevlendirilebilirsiniz."

/obj/effect/landmark/start/maint
	name = JOB_MAINT_TECH
	icon_state = "mt_spawn"
	job = /datum/job/logistics/maint
