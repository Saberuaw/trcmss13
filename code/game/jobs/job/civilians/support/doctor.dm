//job options for doctors surgeon pharmacy technician(preparation of medecine and distribution)

#define DOCTOR_VARIANT "Doctor"
#define SURGEON_VARIANT "Surgeon"

// Doctor
/datum/job/civilian/doctor
	title = JOB_DOCTOR
	total_positions = 5
	spawn_positions = 5
	allow_additional = 1
	scaled = 1
	supervisors = "Başhekim"
	selection_class = "job_doctor"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor

	// job option
	job_options = list(DOCTOR_VARIANT = "Doc", SURGEON_VARIANT = "Sur")
	/// If this job is a doctor variant of the doctor role
	var/doctor = TRUE

//check the job option. and change the gear preset
/datum/job/civilian/doctor/handle_job_options(option)
	if(option != SURGEON_VARIANT)
		doctor = TRUE
		gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor
	else
		doctor = FALSE
		gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/doctor/surgeon

//check what job option you took and generate the corresponding the good texte.
/datum/job/civilian/doctor/generate_entry_message(mob/living/carbon/human/H)
	if(doctor)
		. = {"Denizcileri sağlıklı ve savaşabilecek durumda tutmakla görevli bir doktorsunuz. Tıp ile ilgili her işte uzmansınız. İlaç hazırlayabilir ve ameliyat yapabilirsiniz."}
	else
		. = {"Denizcileri sağlıklı ve savaşabilecek durumda tutmakla görevli bir cerrahsınız. Tıp ile ilgili her işte uzmansınız. İlaç hazırlayabilir ve ameliyat yapabilirsiniz."}

/datum/job/civilian/doctor/set_spawn_positions(count)
	spawn_positions = doc_slot_formula(count)

/datum/job/civilian/doctor/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = doc_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/civilian/doctor, list(
	JOB_MEDIC_ROLES = 1 HOURS
))

/obj/effect/landmark/start/doctor
	name = JOB_DOCTOR
	icon_state = "doc_spawn"
	job = /datum/job/civilian/doctor
