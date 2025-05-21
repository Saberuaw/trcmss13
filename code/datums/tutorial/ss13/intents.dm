/datum/tutorial/ss13/intents
	name = "Space Station 13 - Intentler"
	desc = "Intent sisteminin nasıl işlediğini öğretir."
	icon_state = "intents"
	tutorial_id = "ss13_intents_1"
	tutorial_template = /datum/map_template/tutorial/s7x7
	required_tutorial = "ss13_basic_1"

// START OF SCRIPTING

/datum/tutorial/ss13/intents/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()
	message_to_player("Bu, SS13'ün <b>intent</b> sistemi için bir eğitimdir. Ekranın sağ altında parlayan kısım intentleri, parlayan intent ise hangi intentte olduğunuzu gösterir.")
	var/datum/hud/human/human_hud = tutorial_mob.hud_used
	add_highlight(human_hud.action_intent)

	addtimer(CALLBACK(src, PROC_REF(require_help)), 4.5 SECONDS)

/datum/tutorial/ss13/intents/proc/require_help()
	tutorial_mob.a_intent_change(INTENT_DISARM)
	message_to_player("Intentin help'ten shove'a değiştirildi. <b>Help</b> intentine geri gelmek için <b>[retrieve_bind("select_help_intent")]</b> tuşuna bas.")
	update_objective("[retrieve_bind("select_help_intent")] Tuşuna basarak intentini değiştir.")

	RegisterSignal(tutorial_mob, COMSIG_MOB_INTENT_CHANGE, PROC_REF(on_help_intent))

/datum/tutorial/ss13/intents/proc/on_help_intent(datum/source, new_intent)
	SIGNAL_HANDLER

	if(new_intent != INTENT_HELP)
		return

	UnregisterSignal(tutorial_mob, COMSIG_MOB_INTENT_CHANGE)

	var/mob/living/carbon/human/dummy/tutorial/tutorial_dummy = new(loc_from_corner(2, 3))
	add_to_tracking_atoms(tutorial_dummy)

	message_to_player("İlk intent <b>help</b> intentidir. Zarar vermeden başkalarına dokunmak, yanan insanları söndürmek, ve CPR yapmak gibi şeyler için kullanılır. Help intentinde olduğundan emin olduktan sonra önündeki <b>Kuklaya</b> tıkla.")
	update_objective("Help intentindeyken kuklaya tıkla.")

	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_help_attack))

/datum/tutorial/ss13/intents/proc/on_help_attack(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if((attacked_mob == src) || (tutorial_mob.a_intent != INTENT_HELP))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	tutorial_dummy.status_flags = DEFAULT_MOB_STATUS_FLAGS
	REMOVE_TRAIT(tutorial_dummy, TRAIT_IMMOBILIZED, TRAIT_SOURCE_TUTORIAL)
	tutorial_dummy.anchored = FALSE

	message_to_player("İkinci intent <b>disarm</b> intentidir. <b>[retrieve_bind("select_disarm_intent")]</b> tuşuna basarak aktifleştirilebilir. Disarm, insanları iterek eşyalarını veya onları yere düşürmek için kullanılır. <b>Kukla</b> yere düşene kadar ona tıkla.")
	update_objective("[retrieve_bind("select_disarm_intent")] tuşuna basarak disarm intentine geç ve kukla düşene kadar ona tıkla.")

	RegisterSignal(tutorial_dummy, COMSIG_LIVING_APPLY_EFFECT, PROC_REF(on_shove_down))

/datum/tutorial/ss13/intents/proc/on_shove_down(datum/source, datum/status_effect/new_effect)
	SIGNAL_HANDLER

	if(!istype(new_effect, /datum/status_effect/incapacitating/knockdown))
		return

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	UnregisterSignal(tutorial_dummy, COMSIG_LIVING_APPLY_EFFECT)
	tutorial_dummy.rejuvenate()

	message_to_player("Üçüncü intent <b>grab</b> intentidir. Grab, insanları pasif, agresif veya boğmak için kullanılır. Grab seviyeni arttırmak için tuttuğun kişiye bir daha tıklamalısın. Kuklayı agresif bir şekilde tut.")
	update_objective("Kuklaya iki kere tıkla ve onu agresif bir şekilde tut")


	RegisterSignal(tutorial_dummy, COMSIG_MOB_AGGRESSIVELY_GRABBED, PROC_REF(on_aggrograb))

/datum/tutorial/ss13/intents/proc/on_aggrograb(datum/source, mob/living/carbon/human/choker)
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	UnregisterSignal(tutorial_dummy, COMSIG_MOB_AGGRESSIVELY_GRABBED)

	message_to_player("Dördüncü ve son intent <b>harm</b> intentidir. Harm, insanları yumruklarınız veya bıçak gibi yakın dövüş silahları ile yaralamak için kullanılır. <b>Kuklayı</b> elin boşken yumrukla.")
	update_objective("Boş elle kuklaya saldır.")

	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_harm_attack))

/datum/tutorial/ss13/intents/proc/on_harm_attack(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if((attacked_mob == src) || (tutorial_mob.a_intent != INTENT_HARM))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human/dummy/tutorial, tutorial_dummy)
	tutorial_dummy.status_flags = GODMODE

	message_to_player("Harika! Bunlar intent sisteminin temelleriydi. Eğitim kısa süre içerisinde bitecek.")
	update_objective("")

	tutorial_end_in(5 SECONDS, TRUE)

// END OF SCRIPTING
// START OF SCRIPT HELPERS



// END OF SCRIPT HELPERS

/datum/tutorial/ss13/intents/init_mob()
	. = ..()
	tutorial_mob.forceMove(loc_from_corner(2, 0))
