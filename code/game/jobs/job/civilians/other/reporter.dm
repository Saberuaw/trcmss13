#define MILITARY_VARIANT "Military Correspondent"
#define CIVILIAN_VARIANT "Civilian Correspondent"

/datum/job/civilian/reporter
	title = JOB_COMBAT_REPORTER
	total_positions = 1
	spawn_positions = 1
	selection_class = "job_cl"
	supervisors = "Komutan"
	gear_preset = /datum/equipment_preset/uscm_ship/reporter
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	selection_class = "job_cl"

	job_options = list(CIVILIAN_VARIANT = "Civ", MILITARY_VARIANT = "Mil")
	/// If this job is a military variant of the reporter role
	var/military = FALSE

/datum/job/civilian/reporter/handle_job_options(option)
	if(option != CIVILIAN_VARIANT)
		gear_preset = /datum/equipment_preset/uscm_ship/reporter_uscm
		military = TRUE
	else
		gear_preset = initial(gear_preset)
		military = initial(military)

/datum/job/civilian/reporter/generate_entry_message(mob/living/carbon/human/H)
	if(military)
		. = {"USCM, Neroid Bölgesinde işlerin nasıl yürüdüğüne dair haberleşmeyi daha iyi idare edebilmek için sizi görevlendirdi! Dışarı çıkın ve evrene USCM'nin ne kadar harika şeyler yaptığını gösterin!"}
	else
		. = {"Ne haber ama! Ne tür bir yaramazlık yapacaklarını görmek için görevlendirildiniz ve görünen o ki bela burada!
Bu Bölgenin en iyi hikâyesi olma potansiyeli taşıyor! “Tehlikeli ve bilinmez yardım sinyaline cevap veren cesur denizciler!" Bay Kanarya'ya böyle bir hikaye götürürseniz dikkatini çekeceğinize hiçbir şüphe yok!"}

/obj/effect/landmark/start/reporter
	name = JOB_COMBAT_REPORTER
	icon_state = "cc_spawn"
	job = /datum/job/civilian/reporter

AddTimelock(/datum/job/civilian/reporter, list(
	JOB_HUMAN_ROLES = 10 HOURS,
))
