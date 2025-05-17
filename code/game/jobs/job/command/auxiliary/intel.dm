//Intelligence Officer
/datum/job/command/intel
	title = JOB_INTEL
	total_positions = 3
	spawn_positions = 3
	allow_additional = 1
	scaled = 1
	supervisors = "Destek Subayı"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = "USCM Intelligence Officer (IO) (Cryo)"
	entry_message_body = "Görevin, gezegene inip mevcut operasyonla ilgili istihbarat toplamaktır. Operasyon sahasında bulabileceğiniz tüm veri disklerini, dosyaları ve notları toplamak ve USCM'ye ek kaynaklar sağlamak için şifrelerini çözmektir."

/datum/job/command/intel/set_spawn_positions(count)
	spawn_positions = int_slot_formula(count)

/datum/job/command/intel/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = int_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/command/intel, list(
	JOB_SQUAD_ROLES = 5 HOURS
))

/obj/effect/landmark/start/intel
	name = JOB_INTEL
	icon_state = "io_spawn"
	job = /datum/job/command/intel
