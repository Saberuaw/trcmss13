#define WAITING_HEALTH_THRESHOLD 300

/datum/tutorial/xenomorph/basic
	name = "Xenomorph - Temeller"
	desc = "Xenomorph oynamak için temel bilgileri edinebileceğiniz eğitim."
	icon_state = "xeno"
	tutorial_id = "xeno_basic_1"
	tutorial_template = /datum/map_template/tutorial/s12x12
	starting_xenomorph_type = /mob/living/carbon/xenomorph/drone
	required_tutorial = "ss13_intents_1"

// START OF SCRITPING

/datum/tutorial/xenomorph/basic/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()

	xeno.plasma_stored = 0
	xeno.plasma_max = 0
	xeno.melee_damage_lower = 40
	xeno.melee_damage_upper = 40
	xeno.lock_evolve = TRUE

	message_to_player("Xenomorph temellerinin öğretildiği eğitime hoş geldin. Adın [xeno.name] ve bir drone'sun.")

	addtimer(CALLBACK(src, PROC_REF(on_stretch_legs)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_stretch_legs()
	message_to_player("Bir drone olarak weed yaymak, duvar yapmak, yumurtaları ekmek ve yakalanan insanları nestlemek gibi Hive'ın ihtiyaç duyacağı temel şeyleri yapmakla sorumlusun.")
	addtimer(CALLBACK(src, PROC_REF(on_inform_health)), 5 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_inform_health()
	message_to_player("Ekranının sağındaki parlak <b>yeşil</b> ikon ve karakterinin yanındaki yeşil bar senin canını simgeleyen bir göstergedir.")
	addtimer(CALLBACK(src, PROC_REF(on_give_plasma)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_give_plasma()
	message_to_player("Ayrıca yeteneklerini kullanmak için bir araç olan <b>plazma</b>ya da sahipsin. Ekranının sağındaki parlak <b>mavi</b> ikon ve karakterinin yanındaki mavi bar senin plazmanı simgeleyen bir göstergedir.")
	xeno.plasma_max = 200
	xeno.plasma_stored = 200
	addtimer(CALLBACK(src, PROC_REF(on_damage_xenomorph)), 15 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_damage_xenomorph()
	xeno.apply_damage(350)
	xeno.emote("hiss")
	message_to_player("Eyvah! Görünüşe göre zarar görmüşsün. Yeşil can barlarının azaldığını görebilirsin. Xenomorphlar weedlerin üzerinde durarak veya yatarak canlarını yenileyebilir.")
	addtimer(CALLBACK(src, PROC_REF(request_player_plant_weed)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/request_player_plant_weed()
	update_objective("Yeni edindiğin <b>Weed ekme</b> özelliğini kullanarak weed ek.")
	give_action(xeno, /datum/action/xeno_action/onclick/plant_weeds)
	message_to_player("Ekranının üstündeki yeni özelliğini kullanarak bir weed node ek ve weedlerin yayılmasını sağla. Weedler xenomorphları iyileştirir ve plazmalarını yeniler. Ayrıca insanları yavaşlatarak onlara karşı savaşmanızı kolaylaştırır.")
	RegisterSignal(xeno, COMSIG_XENO_PLANT_RESIN_NODE, PROC_REF(on_plant_resinode))

/datum/tutorial/xenomorph/basic/proc/on_plant_resinode()
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_PLANT_RESIN_NODE)
	message_to_player("Güzel. [retrieve_bind("rest")] tuşuna basarak weedlerin üzerine <b>yatabilir</b> ve daha hızlı iyileşebilirsin.")
	message_to_player("Plazma kapasiten arttırıldı. Ayrıca weedlerin üzerindeyken plazmanın yenilendiğini de görebilirsin.")
	give_action(xeno, /datum/action/xeno_action/onclick/xeno_resting)
	update_objective("Canın en azından [WAITING_HEALTH_THRESHOLD] olana kadar weedlerin üzerinde yat.")
	xeno.plasma_max = 500
	RegisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS, PROC_REF(on_xeno_gain_health))

/datum/tutorial/xenomorph/basic/proc/on_xeno_gain_health()
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS)
	message_to_player("Weedlerin üzerindeyken bile iyileşmek oldukça uzun sürer. Bu süreç feromon kullanılarak hızlandırılabilir. \"Recovery\" feromonu yayarak iyileşme sürecini hızlandır.")
	give_action(xeno, /datum/action/xeno_action/onclick/emit_pheromones)
	update_objective("Recovery feromonu yay.")
	RegisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES, PROC_REF(on_xeno_emit_pheromone))

/datum/tutorial/xenomorph/basic/proc/on_xeno_emit_pheromone(emitter, pheromone)
	SIGNAL_HANDLER
	if(!(pheromone == "recovery"))
		message_to_player("Bu recovery feromonu değil. Yaydığın feromonu değiştirmek için yeteneğine tekrar tıkla ve <b>Recovery</b>'yi seç.")
	else if(xeno.health > WAITING_HEALTH_THRESHOLD)
		reach_health_threshold()
		UnregisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES)
	else
		UnregisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES)
		message_to_player("Güzel. Recovery feromonu iyileşme hızını gözle görülebilir ölçüde hızlandıracak. Canın [WAITING_HEALTH_THRESHOLD] olana kadar beklemeye devam et.")
		message_to_player("Yaydığın feromonun efekti, sana yakın olan xenomorphları da etkiler.")
		RegisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS, PROC_REF(reach_health_threshold))

/datum/tutorial/xenomorph/basic/proc/reach_health_threshold()
	SIGNAL_HANDLER
	if(xeno.health < WAITING_HEALTH_THRESHOLD)
		return

	UnregisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS)

	message_to_player("Güzel.")
	message_to_player("Düşmancıl bir insan, başka bir deyişle \"konak\" belirdi. Onu öldürmek için <b>harm intent</b>e geç ve saldır!")
	update_objective("İnsanı öldür!")

	var/mob/living/carbon/human/human_dummy = new(loc_from_corner(7,7))
	add_to_tracking_atoms(human_dummy)
	add_highlight(human_dummy, COLOR_RED)
	RegisterSignal(human_dummy, COMSIG_MOB_DEATH, PROC_REF(on_human_death_phase_one))

/datum/tutorial/xenomorph/basic/proc/on_human_death_phase_one()
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)

	UnregisterSignal(human_dummy, COMSIG_MOB_DEATH)
	message_to_player("Tebrikler. İnsanları öldürmek, hive'a yardım etmenin en temel birkaç yolundan biridir.")
	message_to_player("Başka bir seçenek ise onları <b>yakalamak</b>tır. Bu yöntemle onların vücutlarının içinde bir yeni bir larva büyütebilirsin. Larva yeterince zaman geçtikten sonra insanın göğsünden dışarı çıkacak ve hive'a oynanabilir yeni bir xenomorph olarak katılacaktır.")
	update_objective("")
	addtimer(CALLBACK(human_dummy, TYPE_PROC_REF(/mob/living, rejuvenate)), 8 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(proceed_to_tackle_phase)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/proceed_to_tackle_phase()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	remove_highlight(human_dummy)
	RegisterSignal(human_dummy, COMSIG_MOB_TAKE_DAMAGE, PROC_REF(on_tackle_phase_human_damage))
	RegisterSignal(human_dummy, COMSIG_MOB_TACKLED_DOWN, PROC_REF(proceed_to_cap_phase))
	message_to_player("<b>Disarm intent</b>'i kullanarak insanı yere düşür.")
	update_objective("İnsanı yere düşür!")

/datum/tutorial/xenomorph/basic/proc/on_tackle_phase_human_damage(source, damagedata)
	SIGNAL_HANDLER
	if(damagedata["damage"] <= 0)
		return
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	// Rejuvenate the dummy if it's less than half health so our player can't kill it and softlock themselves.
	if(human_dummy.health < (human_dummy.maxHealth / 2))
		message_to_player("İnsana zarar verme!")
		human_dummy.rejuvenate()

/datum/tutorial/xenomorph/basic/proc/proceed_to_cap_phase()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)

	UnregisterSignal(human_dummy, COMSIG_MOB_TACKLED_DOWN)

	ADD_TRAIT(human_dummy, TRAIT_KNOCKEDOUT, TRAIT_SOURCE_TUTORIAL)
	ADD_TRAIT(human_dummy, TRAIT_FLOORED, TRAIT_SOURCE_TUTORIAL)
	xeno.melee_damage_lower = 0
	xeno.melee_damage_upper = 0
	message_to_player("Tebrikler Normal şartlar altında yerde kalmalarını sağlamak için onları yol boyunca itmeye devam etmen gerekir ancak bu bir eğitim olduğundan eğitimin geri kalanı boyunca yerde kalacak.")
	update_objective("")
	addtimer(CALLBACK(src, PROC_REF(cap_phase)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/cap_phase()
	var/obj/effect/alien/resin/special/eggmorph/morpher = new(loc_from_corner(2,2), GLOB.hive_datum[XENO_HIVE_TUTORIAL])
	morpher.stored_huggers = 1
	add_to_tracking_atoms(morpher)
	add_highlight(morpher, COLOR_YELLOW)
	message_to_player("Sol altında olan şey bir egg morpher. Ona tıklayarak içinden bir <b>facehugger</b> al.")
	update_objective("Eggmorpher'dan bir facehugger al.")
	RegisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER, PROC_REF(take_facehugger_phase))

/datum/tutorial/xenomorph/basic/proc/take_facehugger_phase(source, hugger)
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/effect/alien/resin/special/eggmorph, morpher)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	add_to_tracking_atoms(hugger)
	remove_highlight(morpher)

	add_highlight(hugger, COLOR_YELLOW)
	message_to_player("Etrafı sarı parlayan şey bir facehugger. Tıklayarak yerden al.")
	message_to_player("Yerde yatan insanın yanına gel ve ona tıklayarak elindeki facehuggerı suratına yerleştir veya facehuggerı yere bırakarak otomatik bir şekilde suratına atlamasını sağla.")
	update_objective("Facehuggerı insanın suratına yerleştir.")
	RegisterSignal(hugger, COMSIG_PARENT_QDELETING, PROC_REF(on_hugger_deletion))
	RegisterSignal(human_dummy, COMSIG_HUMAN_IMPREGNATE, PROC_REF(nest_cap_phase), override = TRUE)

/datum/tutorial/xenomorph/basic/proc/on_hugger_deletion(hugger)
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/obj/effect/alien/resin/special/eggmorph, morpher)
	morpher.stored_huggers = 1
	add_highlight(morpher, COLOR_YELLOW)
	message_to_player("Egg morpher'a tıklayarak içinden bir <b>facehugger</b> al.")
	update_objective("Eggmorpher'dan bir facehugger al.")
	RegisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER, PROC_REF(take_facehugger_phase))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/clothing/mask/facehugger, hugger)
	UnregisterSignal(human_dummy, COMSIG_MOB_TAKE_DAMAGE)
	UnregisterSignal(human_dummy, COMSIG_HUMAN_IMPREGNATE)
	UnregisterSignal(hugger, COMSIG_PARENT_QDELETING)
	remove_highlight(hugger)

	message_to_player("Enfekte ettiğin insanın kaçmasını engellemek için onu asmalısın.")
	message_to_player("İnsanlar asıldıkları yerden yardım olmadan kaçamaz. Ayrıca yuvaları, asıldıkları zaman içlerinden yeni bir xenomorph çıkana kadar onları hayatta tutar.")
	update_objective("")
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_two)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_two()

	loc_from_corner(8,0).ChangeTurf(/turf/closed/wall/resin/tutorial)
	loc_from_corner(8,1).ChangeTurf(/turf/closed/wall/resin/tutorial)
	loc_from_corner(9,1).ChangeTurf(/turf/closed/wall/resin/tutorial)

	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_three)), 5 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_three()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	message_to_player("Grab intentini veya control + click kullanarak insanı tut.")
	update_objective("Grab intentini veya control + click kullanarak insanı tut.")
	RegisterSignal(human_dummy, COMSIG_MOVABLE_XENO_START_PULLING, PROC_REF(nest_cap_phase_four))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_four()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOVABLE_XENO_START_PULLING)
	message_to_player("Tebrikler. Şimdi insanı tuttuğun elin aktifken kendine tıkla ve insanı sıkıca yakala. Bu işlem sırasında hareket etmemelisin")
	update_objective("Yakaladığın insanı, onu yakaladığın el aktif elinken kendine tıklayarak sıkıca kavra")
	RegisterSignal(human_dummy, COMSIG_MOB_HAULED, PROC_REF(nest_cap_phase_five))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_five()
	SIGNAL_HANDLER
	message_to_player("Tebrikler, şimdi yeni edindiğin yeteneğinle insanı serbest bırak.")
	message_to_player("Unutma, gerçek insanlar bu süreç içerisinde sana karşı koyacak ve tutuşundan kaçmak için seninle savaşacaktır.")
	give_action(xeno, /datum/action/xeno_action/onclick/release_haul)
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_six)), 15 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_six()
	message_to_player("İnsanlar sadece <b>hive weed</b> denen özel bir weed türünün olduğu yerlere asılabilir. Bu özel weedler hive core ve hive cluster gibi özel yapılar tarafından üretilir.T")
	message_to_player("Sağ altta yakaladığın insanı asman için hive weedleri ve duvarları var.")
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_seven)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_seven()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOB_HAULED)
	RegisterSignal(human_dummy, COMSIG_MOB_NESTED, PROC_REF(on_mob_nested))
	message_to_player("Yakaladığın insanı as!")
	update_objective("Yakaladığın insanı as!")
	message_to_player("İnsanı duvarın yanına sürükle, böylece hem sen hem de insan duvara bitişik olur.")
	message_to_player("İnsanı tuttuğun elinle duvara tıkla veya insanın karakterine tıklayıp mouse'unu duvara sürükle. Bu işlem sırasında hareket etmemelisin.")
	new /obj/effect/alien/resin/special/cluster(loc_from_corner(9,0), GLOB.hive_datum[XENO_HIVE_TUTORIAL])

/datum/tutorial/xenomorph/basic/proc/on_mob_nested()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOB_NESTED)

	message_to_player("Tebrikler, bununla birlikte xenomorph temellerini öğrenmiş oldun!")
	message_to_player("Bu eğitim kısa süre içinde bitecek.")
	tutorial_end_in(10 SECONDS)

// END OF SCRIPTING

/datum/tutorial/xenomorph/basic/init_map()
	loc_from_corner(9,0).ChangeTurf(/turf/closed/wall/resin/tutorial)

#undef WAITING_HEALTH_THRESHOLD
