/datum/job/civilian/synthetic
	title = JOB_SYNTH
	total_positions = 2
	spawn_positions = 1
	allow_additional = 1
	scaled = 1
	supervisors = "Komutan"
	selection_class = "job_synth"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADMIN_NOTIFY|ROLE_WHITELISTED|ROLE_CUSTOM_SPAWN
	flags_whitelist = WHITELIST_SYNTHETIC
	gear_preset = /datum/equipment_preset/synth/uscm
	loadout_points = 120
	entry_message_body = "Sen bir sentetiksin! Whitelistli bir rol oynadığından genel oyuncu topluluğuna göre daha yüksek bir standarda tabi tutulursun. Sunucu kurallarına, Denizci Yasası'na ve Sentetik kurallarına uymak zorundasın. Bunları ihlal etmen whitelistten çıkarılmana neden olabilir. Öncelikli görevin, gemideki departmanlara ve tüm personele destek ve yardımcı olmaktır."

/datum/job/civilian/synthetic/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_SYNTH][WHITELIST_NORMAL]" = /datum/equipment_preset/synth/uscm,
		"[JOB_SYNTH][WHITELIST_COUNCIL]" = /datum/equipment_preset/synth/uscm/councillor,
		"[JOB_SYNTH][WHITELIST_LEADER]" = /datum/equipment_preset/synth/uscm/councillor
	)

/datum/job/civilian/synthetic/get_whitelist_status(client/player)
	. = ..()
	if(!.)
		return

	if(player.check_whitelist_status(WHITELIST_SYNTHETIC_LEADER))
		return get_desired_status(player.prefs.synth_status, WHITELIST_LEADER)
	if(player.check_whitelist_status(WHITELIST_SYNTHETIC_COUNCIL|WHITELIST_SYNTHETIC_COUNCIL_LEGACY))
		return get_desired_status(player.prefs.synth_status, WHITELIST_COUNCIL)
	if(player.check_whitelist_status(WHITELIST_SYNTHETIC))
		return get_desired_status(player.prefs.synth_status, WHITELIST_NORMAL)

/datum/job/civilian/synthetic/set_spawn_positions(count)
	spawn_positions = synth_slot_formula(count)

/datum/job/civilian/synthetic/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = synth_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

/obj/effect/landmark/start/synthetic
	name = JOB_SYNTH
	icon_state = "syn_spawn"
	job = /datum/job/civilian/synthetic
