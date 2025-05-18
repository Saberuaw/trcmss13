/datum/job/civilian/liaison
	title = JOB_CORPORATE_LIAISON
	total_positions = 1
	spawn_positions = 1
	supervisors = "Weyland-Yutani"
	selection_class = "job_cl"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/liaison
	entry_message_body = "Weyland-Yutani'nin Şirket İlişkileri Departmanı'ndan bir temsilci olarak işin, her zaman karakterde kalmanı gerektiriyor. Operasyon alanındayken Askeri Personel tarafından verilen emirlere uymanız beklenir. Gemide ise sadece Komutanın ve İnzibatın emirlerine tabisiniz. Size verilen herhangi bir emre uymak zorunda değilsiniz ancak uymadığınız takdirde tutuklanabilirsiniz. Öncelikli göreviniz gemide gözlem yapmak ve bulgularınızı Weyland-Yutani'ye faks aracılığıyla rapor etmektir. Weyland-Yutani(Adminler) tarafından aksi söylenmedikçe normal kurallara uymalısınız. Şirket merkeziyle iletişim kurmak veya yeni direktifler almak için ofisinizdeki faks makinesini kullanın. Gönderdiğiniz fakslara yanıt alamazsanız endişe etmeyin, bu çoğu zaman normaldir."
	var/mob/living/carbon/human/active_liaison

/datum/job/civilian/liaison/generate_entry_conditions(mob/living/liaison, whitelist_status)
	. = ..()
	active_liaison = liaison
	RegisterSignal(liaison, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_liaison))

/datum/job/civilian/liaison/proc/cleanup_active_liaison(mob/liaison)
	SIGNAL_HANDLER
	active_liaison = null

/obj/effect/landmark/start/liaison
	name = JOB_CORPORATE_LIAISON
	icon_state = "cl_spawn"
	job = /datum/job/civilian/liaison

AddTimelock(/datum/job/civilian/liaison, list(
	JOB_HUMAN_ROLES = 10 HOURS,
))
