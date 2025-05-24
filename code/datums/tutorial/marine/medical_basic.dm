/datum/tutorial/marine/medical_basic
	name = "Marine - Medikal (Temel)"
	desc = "Bir askerin savaş alanında sık sık karşılaşabileceği temel yaralanmaları nasıl tedavi edebileceğini öğretir."
	tutorial_id = "marine_medical_1"
	tutorial_template = /datum/map_template/tutorial/s7x7
	required_tutorial = "marine_basic_1"

// START OF SCRIPTING

/datum/tutorial/marine/medical_basic/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()
	message_to_player("Bu, Marine olarak oynarken ihtiyacın olabilecek basit tedavileri içeren bir eğitimdir.")
	addtimer(CALLBACK(src, PROC_REF(brute_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/brute_tutorial()
	message_to_player("İlk hasar tipi <b>Brute</b> hasardır. En sık karşılaşacağınız hasar tipidir. Yumruklanmak ve mermi yemek gibi fiziksel şeylerden kaynaklanır.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.adjustBruteLoss(10)
	addtimer(CALLBACK(src, PROC_REF(brute_tutorial_2)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/brute_tutorial_2()
	message_to_player("<b>Brute</b> veya <b>Burn</b> hasarın olduğunu düşünüyorsan bunu kendine elin boş ve help intentindeyken tıklayarak öğrenebilirsin.")
	update_objective("Elin boşken kendine tıkla.")
	RegisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN, PROC_REF(on_health_examine))

/datum/tutorial/marine/medical_basic/proc/on_health_examine(datum/source, mob/living/carbon/human/attacked_mob)
	SIGNAL_HANDLER

	if(attacked_mob != tutorial_mob)
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_ATTACKHAND_HUMAN)
	message_to_player("Güzel. Şimdi, görebileceğin üzere karakterini biraz yaraladım. <b>Bicaridine</b>, brute hasarı zaman geçtikçe iyileştiren bir kimasaldır. Masanın üstündeki <b>bicaridine EZ autoinjector</b>u al ve kendine tıklayarak kullan.")
	update_objective("Bicaridine injector'u kendine enjekte et.")
	var/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use/brute_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(brute_injector)
	add_highlight(brute_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_brute_inject))

/datum/tutorial/marine/medical_basic/proc/on_brute_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless/one_use, brute_injector)
	remove_highlight(brute_injector)
	message_to_player("Bütün ilaçlar vücuda girdikten biraz sonra etki gösterir. Bir sonraki hasar tipi <b>Burn</b> hasarı. Asit tarafından hasar almak veya ateşe girmek gibi sebeplerden kaynaklanır.")
	update_objective("")
	var/mob/living/living_mob = tutorial_mob
	living_mob.adjustFireLoss(10)
	addtimer(CALLBACK(src, PROC_REF(burn_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/burn_tutorial()
	message_to_player("<b>Kelotane</b>, burn hasarı zaman geçtikçe iyileştiren bir kimyasaldır. Masanın üstündeki <b>kelotane EZ autoinjector</b>.'u al ve kendine tıkla.")
	update_objective("Kelotane injector'u kendine enjekte et.")
	var/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use/burn_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(burn_injector)
	add_highlight(burn_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_burn_inject))


/datum/tutorial/marine/medical_basic/proc/on_burn_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless/one_use, burn_injector)
	remove_highlight(burn_injector)
	message_to_player("Güzel. Şimdi sana biraz acıdan bahsedeceğim. Normalde hasar aldığında bu hasar acıya da sebep olur. Acı seni yavaşlatır ve ekstrem durumlarda bayılmana bile neden olabilir.")
	update_objective("")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.apply_pain(PAIN_CHESTBURST_STRONG)
	addtimer(CALLBACK(src, PROC_REF(pain_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/pain_tutorial()
	message_to_player("<b>Tramadol</b> hissedilen acıyı azaltmak için kullanılan bir ağrı kesicidir. Masanın üstündeki <b>tramadol EZ autoinjector</b>'u al ve kendine tıkla.")
	update_objective("Tramadol injector'u kendine enjekte et.")
	var/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use/pain_injector = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(pain_injector)
	add_highlight(pain_injector)
	RegisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED, PROC_REF(on_pain_inject))

/datum/tutorial/marine/medical_basic/proc/on_pain_inject(datum/source, obj/item/reagent_container/hypospray/injector)
	SIGNAL_HANDLER

	if(!istype(injector, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use))
		return

	UnregisterSignal(tutorial_mob, COMSIG_LIVING_HYPOSPRAY_INJECTED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless/one_use, pain_injector)
	remove_highlight(pain_injector)
	message_to_player("Güzel. unutma, kimyasallar çok kullanıldıklarında Overdosa'a neden olurlar. Bu yüzden aynı kimyasalı biraz zaman geçmeden kendine tekrardan enjekte etme.")
	update_objective("Overdose olma! Bir enjektörün içindeki kimyasalı 2 kere art arda enjekte etmek, karakterini genelde OD sınırına getirir. 3 kullanım ise karakterini OD yapar.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.apply_pain(-PAIN_CHESTBURST_STRONG) // just to make sure
	addtimer(CALLBACK(src, PROC_REF(bleed_tutorial)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/bleed_tutorial()
	message_to_player("Mermi veya kesiklerin sana isabet etmesi sonucunda <b>Kanama</b>ya başlayabilirsin. Kan kaybı, kalıcı <b>oksijen</b> hasarlarına, ilerleyen süreçte yüksek <b>toksin</b> hasarına ve son noktada canlandırıldıktan hemen sonra anında ölüme neden olabilir.")
	update_objective("")
	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	mob_chest.add_bleeding(damage_amount = 15)
	addtimer(CALLBACK(src, PROC_REF(bleed_tutorial_2)), 4 SECONDS)

/datum/tutorial/marine/medical_basic/proc/bleed_tutorial_2()
	message_to_player("Kanama zaman içinde kendi kendine durabilir veya <b>gauze</b> kullanarak kanamayı hızlıca durdurabilirsin. Gauze'u al ve sağ alttaki karakterin <b>göğsünü</b> seçtikten sonra kendine tıkla.")
	update_objective("Kanayan göğsünü sargıla.")
	var/obj/item/stack/medical/bruise_pack/two/bandage = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(bandage)
	add_highlight(bandage)
	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	RegisterSignal(mob_chest, COMSIG_LIMB_STOP_BLEEDING, PROC_REF(on_chest_bleed_stop))

/datum/tutorial/marine/medical_basic/proc/on_chest_bleed_stop(datum/source, external, internal)
	SIGNAL_HANDLER

	// If you exit on this step, your limbs get deleted, which stops the bleeding, which progresses the tutorial despite it ending
	if(!tutorial_mob || QDELETED(src))
		return

	var/mob/living/carbon/human/human_mob = tutorial_mob
	var/obj/limb/chest/mob_chest = locate(/obj/limb/chest) in human_mob.limbs
	UnregisterSignal(mob_chest, COMSIG_LIMB_STOP_BLEEDING)

	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/stack/medical/bruise_pack/two, bandage)
	remove_from_tracking_atoms(bandage)
	remove_highlight(bandage)
	qdel(bandage)

	message_to_player("Güzel. Bazen patlamalar ve çeşitli sebeplerden dolayı vücuduna <b>şarapnel</b>ler girebilir. Vücudunda şarapnel varken hareket edersen kemiğin kırılabilir veya organların hasar görebilir. Şarapneli çıkarmak için <b>bıçağını</b> al ve <b>[retrieve_bind("activate_inhand")]</b> tuşuna basarak şarapneli çıkar.")
	update_objective("Bıçağını kullanarak şarapnelleri çıkar.")
	var/mob/living/living_mob = tutorial_mob
	living_mob.pain.feels_pain = FALSE

	var/obj/item/attachable/bayonet/knife = new(loc_from_corner(0, 4))
	add_to_tracking_atoms(knife)
	add_highlight(knife)

	var/obj/item/shard/shrapnel/tutorial/shrapnel = new
	shrapnel.on_embed(tutorial_mob, mob_chest, TRUE)

	RegisterSignal(tutorial_mob, COMSIG_HUMAN_SHRAPNEL_REMOVED, PROC_REF(on_shrapnel_removed))

/datum/tutorial/marine/medical_basic/proc/on_shrapnel_removed()
	SIGNAL_HANDLER

	UnregisterSignal(tutorial_mob, COMSIG_HUMAN_SHRAPNEL_REMOVED)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/attachable/bayonet, knife)
	remove_highlight(knife)
	message_to_player("Güzel. Eğitimin sonuna geldin. Kısa süre içinde lobiye gönderileceksin.")
	update_objective("Eğitim tamamlandı..")
	tutorial_end_in(5 SECONDS)

// END OF SCRIPTING
// START OF SCRIPT HELPERS

// END OF SCRIPT HELPERS

/datum/tutorial/marine/medical_basic/init_mob()
	. = ..()
	arm_equipment(tutorial_mob, /datum/equipment_preset/tutorial/fed)


/datum/tutorial/marine/medical_basic/init_map()
	new /obj/structure/surface/table/almayer(loc_from_corner(0, 4))
