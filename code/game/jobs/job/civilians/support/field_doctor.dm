
/datum/job/civilian/field_doctor
	title = JOB_FIELD_DOCTOR
	total_positions = 1
	spawn_positions = 1
	allow_additional = TRUE
	scaled = TRUE
	supervisors = "Başhekim"
	selection_class = "job_doctor"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/field_doctor
	entry_message_body = "Denizcileri sağlıklı ve savaşabilecek durumda tutmakla görevli bir saha doktorusunuz. Gemide başka doktor yoksa veya FOB güvenli değilse gemide kalmalısınız. Üstleriniz sahaya gönderilmenizi erteleyebilir."

AddTimelock(/datum/job/civilian/field_doctor, list(
	JOB_DOCTOR_ROLES = 5 HOURS
))

/obj/effect/landmark/start/field_doctor
	name = JOB_FIELD_DOCTOR
	icon_state = "field_doc_spawn"
	job = /datum/job/civilian/field_doctor
