/datum/job/civilian/chef
	title = JOB_MESS_SERGEANT
	total_positions = 2
	spawn_positions = 1
	allow_additional = TRUE
	scaled = TRUE
	selection_class = "job_ot"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	supervisors = "Destek Subayı"
	gear_preset = /datum/equipment_preset/uscm_ship/chef
	entry_message_body = "Göreviniz gemi mürettebatına yiyecek ve içecek servisi yapmak, gerektiğinde ise gemi mürettebatını eğlendirmektir. Genel olarak bir sorumluluğunuz yok. Özgürsünüz ve bununla ne yapacağınıza karar vermek size kalmış. İyi şanslar!"

/datum/job/civilian/chef/set_spawn_positions(count)
	spawn_positions = mess_sergeant_slot_formula(count)

/datum/job/civilian/chef/get_total_positions(latejoin = FALSE)
	var/positions = spawn_positions
	if(latejoin)
		positions = mess_sergeant_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions

	return positions

/obj/effect/landmark/start/chef
	name = JOB_MESS_SERGEANT
	icon_state = "chef_spawn"
	job = /datum/job/civilian/chef
