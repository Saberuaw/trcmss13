//Military Police
/datum/job/command/police
	title = JOB_POLICE
	total_positions = 5
	spawn_positions = 5
	allow_additional = 1
	scaled = 1
	selection_class = "job_mp"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_police/mp
	entry_message_body = "Diğer rollere göre daha fazla gücünüz ve sorumluluğunuz olduğundan genel oyuncu topluluğuna göre daha yüksek bir standarda tabi tutulursun. Sadece sunucu kurallarına değil, Denizci Yasası'na da uyman gerekmektedir. Bunların ihlali rol veya sunucu banı ile sonuçlanabilir. Görevin gemide sükuneti ve istikrarı korumak. Buna ek olarak komuta kademesi de dahil olmak üzere yüksek rütbeli personelin güvenliğini sağlamakla görevlisin. Mürettebatı güvende tut!"

/datum/job/command/police/set_spawn_positions(count)
	spawn_positions = mp_slot_formula(count)

/datum/job/command/police/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = mp_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/command/police, list(
	JOB_SQUAD_ROLES = 10 HOURS
))

/obj/effect/landmark/start/police
	name = JOB_POLICE
	icon_state = "mp_spawn"
	job = /datum/job/command/police
