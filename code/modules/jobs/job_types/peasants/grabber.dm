/datum/job/grabber
	title = "Merchantdise Overseer"
	tutorial = "A hired whip in a Zybantine slaver crew, you enforce order with steel and leather. \
	You are hired by the Merchant to oversee the guild's debtors and keep the trade flowing."
	department_flag = COMPANY
	display_order = JDO_GRABBER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 4
	spawn_positions = 4
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/grabber
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'
	exp_types_granted = list(EXP_TYPE_MERCHANT_COMPANY)

	jobstats = list(
		STATKEY_STR = 1,
		STATKEY_SPD = -1,
		STATKEY_END = 1,
	)

	skills = list(
		/datum/skill/combat/whipsflails = 3,
		/datum/skill/combat/crossbows = 2,
		/datum/skill/combat/bows = 2,
		/datum/skill/combat/axesmaces = 2,
		/datum/skill/combat/swords = 3,
		/datum/skill/combat/knives = 3,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 2,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/reading = 1,
		/datum/skill/misc/medicine = 1,
		/datum/skill/misc/riding = 2,
		/datum/skill/craft/crafting = 1,
		/datum/skill/craft/cooking = 1,
		/datum/skill/labor/mathematics = 1
	)

	traits = list(
		TRAIT_MEDIUMARMOR
	)

/datum/job/grabber/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	if(spawned.gender == MALE)
		spawned.adjust_stat_modifier(STATMOD_JOB, STATKEY_STR, 1)
		spawned.adjust_stat_modifier(STATMOD_JOB, STATKEY_CON, 1)
	else
		spawned.adjust_stat_modifier(STATMOD_JOB, STATKEY_INT, 1)
		spawned.adjust_stat_modifier(STATMOD_JOB, STATKEY_SPD, 1)

/datum/outfit/grabber
	name = "Zybantine Whip Mercenary"
	shoes = /obj/item/clothing/shoes/shalal
	head = /obj/item/clothing/head/helmet/sallet
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/shalal
	armor = /obj/item/clothing/armor/brigandine/coatplates
	beltr = /obj/item/weapon/whip
	beltl = /obj/item/weapon/knife/dagger/steel
	shirt = /obj/item/clothing/shirt/undershirt/colored/black
	pants = /obj/item/clothing/pants/tights/colored/red
	neck = /obj/item/clothing/neck/keffiyeh/colored/red
	backl = /obj/item/storage/backpack/satchel

	backpack_contents = list(
		/obj/item/storage/belt/pouch/coins/poor = 1
	)

/datum/outfit/grabber/pre_equip(mob/living/carbon/human/equipped_human, visuals_only)
	. = ..()
