/datum/origin/uscm
	name = ORIGIN_USCM
	desc = "Türkiye Cumhuriyeti'nde, yani bu galaksideki en harika ülkede doğdun."


/datum/origin/uscm/luna
	name = ORIGIN_USCM_LUNA
	desc = "Ay'ın yörüngesindeki bir Ay üssünde doğdun. Kulağa oldukça havalı geliyor, değil mi? Herkes senin gibi düşünüyor, o yüzden pek de havalı değil."


/datum/origin/uscm/other
	name = ORIGIN_USCM_OTHER
	desc = "Türkiye ve Birleşik Amerika arasındaki işbirliğinden faydalanarak göç ettin."


/datum/origin/uscm/colony
	name = ORIGIN_USCM_COLONY
	desc = "Bir Weyland-Yutani kolonisinde doğdun ve bu bok çukurundan kaçmanın tek yolu askere gitmekti, sen de bunu yaptın."


/datum/origin/uscm/foreign
	name = ORIGIN_USCM_FOREIGN
	desc = "Türkiye Cumhuriyeti sınırlarının dışında doğdun."


/datum/origin/uscm/aw
	name = ORIGIN_USCM_AW
	desc = "Mükemmel bir süper asker yetiştirmeyi amaçlayan deneysel bir askeri programın ürünüydün"

/datum/origin/uscm/aw/generate_human_name(gender = MALE)
	return pick(gender == MALE ? GLOB.first_names_male : GLOB.first_names_female) + " A.W. " + pick(GLOB.weapon_surnames)

/datum/origin/uscm/aw/validate_name(name_to_check)
	if(!findtext(name_to_check, "A.W. "))
		return "Bir Artificial-Womb olarak karakterinin adının ve soyadının arasında 'A.W.' olmalı."
	return null

/datum/origin/uscm/aw/correct_name(name_to_check, gender = MALE)
	if(!findtext(name_to_check, "A.W. "))
		name_to_check = generate_human_name(gender)
	return name_to_check

/datum/origin/uscm/convict
	name = null // Abstract type

/datum/origin/uscm/convict/minor
	name = ORIGIN_USCM_CONVICT_MINOR
	desc = "Nerede doğduğunun ve kim olduğunun bir önemi yok, bilindiği kadarıyla çok sayıda küçük suçtan hüküm giydin ve sana tek bir çıkış yolu sunuldu: TRCM."

/datum/origin/uscm/convict/gang
	name = ORIGIN_USCM_CONVICT_GANG
	desc = "Nerede doğduğunun ve kim olduğunun bir önemi yok, bilindiği kadarıyla mafyalıkla ilgili suçlardan dolayı hüküm giydin ve sana tek bir çıkış yolu sunuldu: TRCM."

/datum/origin/uscm/convict/smuggling
	name = ORIGIN_USCM_CONVICT_SMUGGLING
	desc = "Nerede doğduğunun ve kim olduğunun bir önemi yok, bilindiği kadarıyla kaçakçılıktan (ve muhtemelen korsanlıktan) hüküm giydin ve sana tek bir çıkış yolu sunuldu: TRCM."
