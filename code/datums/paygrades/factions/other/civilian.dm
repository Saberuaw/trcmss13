/datum/paygrade/civilian
	name = "Civilian Paygrade"
	pay_multiplier = 0.5 // civvies are poor

/datum/paygrade/civilian/civilian
	paygrade = PAY_SHORT_CIV
	name = "Civilian"
	prefix = "S"

/datum/paygrade/civilian/nurse
	paygrade = PAY_SHORT_CNUR
	name = "Nurse"
	prefix = "Hmşr."

/datum/paygrade/civilian/paramedic
	paygrade = PAY_SHORT_CPARA
	name = "Paramedic"
	prefix = "EMT-P"
	pay_multiplier = 0.6

/datum/paygrade/civilian/doctor
	paygrade = PAY_SHORT_CDOC
	name = "Doctor"
	prefix = "Dr."
	pay_multiplier = 0.75

/datum/paygrade/civilian/professor
	paygrade = PAY_SHORT_CCMO
	name = "Professor"
	prefix = "Prof."
	pay_multiplier = 1
	officer_grade = GRADE_OFFICER

/datum/paygrade/civillian/representative
	paygrade = PAY_SHORT_CREP
	name = "Representative"
	prefix = "Tmslc."
	pay_multiplier = 1

/datum/paygrade/civillian/officer
	paygrade = PAY_SHORT_CPO
	name = "Officer"
	prefix = "Sby."
	pay_multiplier = 0.66

/datum/paygrade/civillian/officer/senior
	paygrade = PAY_SHORT_CSPO
	name = "Senior Officer"
	prefix = "Kıd.Sby."
	pay_multiplier = 0.8
	officer_grade = GRADE_OFFICER

/datum/paygrade/civilian/rebel
	paygrade = PAY_SHORT_REB
	name = "Rebel"

/datum/paygrade/civilian/rebel/leader
	paygrade = PAY_SHORT_REBC
	name = "Rebel Commander"
	prefix = "CMDR."
	officer_grade = GRADE_OFFICER
