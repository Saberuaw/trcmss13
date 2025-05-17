/datum/job/marine
	supervisors = "Aktif Manga Lideri"
	selection_class = "job_marine"
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1

/datum/job/marine/generate_entry_message(mob/living/carbon/human/current_human)
	if(current_human.assigned_squad)
		entry_message_intro = "[title]'sin! <b><font size=3 color=[current_human.assigned_squad.equipment_color]>[lowertext(current_human.assigned_squad.name)] squad</font></b>.[Check_WO() ? "" : " Mangasına atandın! Uzun süreli uyku sonrası açlığını dindirmek için yemek otomatlarından yemek yiyin ve ardından teçhizatınızı kuşanın!" ]"
	return ..()

/datum/job/marine/generate_entry_conditions(mob/living/carbon/human/current_human)
	..()
	if(!Check_WO())
		current_human.nutrition = rand(NUTRITION_VERYLOW, NUTRITION_LOW) //Start hungry for the default marine.

/datum/timelock/squad
	name = "Squad Roles"

/datum/timelock/squad/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_SQUAD_ROLES_LIST
