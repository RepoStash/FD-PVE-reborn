#define COMSIG_KB_HUMAN_RE13_INVENTORY "keybinding_human_re13_inventory"

#define CATEGORY_RE13 "RESIDENT EVIL"

/datum/keybinding/human/re13
	category = CATEGORY_RE13

/datum/keybinding/human/re13/can_use(client/user)

	var/mob/living/carbon/human/human_mob = user.mob

	if(!human_mob.re13_player)
		return FALSE

	. = ..()

/mob/living/carbon/human

	var/re13_maxhp = 3
	var/re13_hp = 3

	var/re13_damage_state = "NORMAL" // "NORMAL" - Никаких дебаффов; "SLIGHTLY WOUNDED" - Действия тратят на [1] стамину больше;
	// "ALMOST DEAD" - Нельзя использовать стамину; "DEAD" - Ю кноу

	var/re13_maxstam = 3
	var/re13_stam = 3

	var/re13_stam_recharge_time = 10
	var/re13_stam_overuse = FALSE

	var/re13_player = TRUE

	var/obj/item/re13_itemslot1
	var/obj/item/re13_itemslot2
	var/obj/item/re13_itemslot3
	var/obj/item/re13_itemslot4
	var/obj/item/re13_itemslot5
	var/obj/item/re13_itemslot6

/mob/living/carbon/human/proc/re13_death()
	stop_pulling()

	animate(src, transform = matrix(rand(-3,3), 0, MATRIX_TRANSLATE), time = 0.5, easing = EASE_IN)
	for(var/i in 0 to 4)
		animate(transform = matrix(rand(-4,4), 0, MATRIX_TRANSLATE), time = 1)
	animate(transform = matrix(0, 0, MATRIX_TRANSLATE), time = 0.5, easing = EASE_OUT)

	spawn(1 SECONDS)
		animate(src, time = 0.5 SECONDS, transform = matrix(90, MATRIX_ROTATE), easing = SINE_EASING)
		ADD_TRAIT(src, TRAIT_UNDENSE, REDEATH_TRAIT)

	spawn(3 SECONDS)
		ADD_TRAIT(src, TRAIT_IMMOBILIZED, REDEATH_TRAIT)

	spawn(4 SECONDS)
		apply_damage(600, OXY)
		death()
		shake_camera(src, 3, 4)

		add_filter("downed", 1, list("type" = "outline", "color" = "#000000", "size" = 1))

/mob/living/carbon/human/proc/re13_revivify()
	animate(src, time = 2 SECONDS, transform = matrix(0, MATRIX_ROTATE), easing = SINE_EASING)

	REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, REDEATH_TRAIT)
	REMOVE_TRAIT(src, TRAIT_UNDENSE, REDEATH_TRAIT)

	re13_stam = re13_maxstam
	re13_hp = re13_maxhp
	re13_stam_recharge_time = initial(re13_stam_recharge_time)
	rejuvenate()

	remove_filter("downed", 1, list("type" = "outline", "color" = "#000000", "size" = 1))
	re13_check_stats()

/mob/living/carbon/human/proc/change_health(amount)
	re13_hp += amount
	if(re13_hp > re13_maxhp)
		re13_hp = re13_maxhp

	re13_check_stats()

/mob/living/carbon/human/proc/change_stam(amount)
	re13_stam += amount
	if(re13_stam > re13_maxstam)
		re13_stam = re13_maxstam

	re13_check_stats()

/mob/living/carbon/human/proc/re13_check_stats()

	if(re13_hp > 0)
		re13_damage_state = "ALMOST DEAD"
	if(re13_hp > 1)
		re13_damage_state = "SLIGHTLY WOUNDED"
	if(re13_hp > 2)
		re13_damage_state = "NORMAL"
	if(re13_hp <= 0)
		re13_damage_state = "DEAD"

	if(re13_damage_state == "DEAD")
		re13_death()

	if(re13_stam <= 0 && !re13_stam_overuse)
		re13_stam_recharge_time += 20
		re13_stam_overuse = TRUE
