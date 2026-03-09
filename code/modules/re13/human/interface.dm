/datum/hud
	var/atom/movable/screen/re13_hp/re13_hp
	var/atom/movable/screen/re13_stam/re13_stam

/datum/keybinding/human/re13/inventory
	hotkey_keys = list("I")
	classic_keys = list("Unbound")
	name = "re13_inventory"
	full_name = "Open Inventory (Player)"
	description = "..."
	keybind_signal = COMSIG_KB_HUMAN_RE13_INVENTORY

/datum/keybinding/human/re13/inventory/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/human_mob = user.mob
	human_mob.hud_used.re13_hp.show_stat(human_mob)
	human_mob.hud_used.re13_stam.show_stat(human_mob)

/datum/keybinding/human/re13/inventory/up(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/human_mob = user.mob
	human_mob.hud_used.re13_hp.hide_stat(human_mob)
	human_mob.hud_used.re13_stam.hide_stat(human_mob)

	return TRUE

/datum/hud/human/proc/draw_re13_hp(datum/custom_hud/ui_datum)
	re13_hp = new /atom/movable/screen/re13_hp()
	re13_hp.icon = ui_datum.ui_style_icon
	re13_hp.screen_loc = "CENTER,CENTER"
	infodisplay += re13_hp

/atom/movable/screen/re13_hp
	name = "current hp"
	icon_state = "re13hp_0"
	alpha = 0
	mouse_opacity = FALSE
	var/already_playing = FALSE

/atom/movable/screen/re13_hp/proc/show_stat(mob/living/carbon/human/user)
	if(user && user.hud_used)
		if(user.re13_player)
			icon_state = "re13hp_[user.re13_hp]"

			if(!already_playing)
				already_playing = TRUE

				animate(src, alpha = 255, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
				animate(src, transform = matrix(0, -8, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)

/atom/movable/screen/re13_hp/proc/hide_stat()
	animate(src, alpha = 0, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
	animate(src, transform = matrix(0, 0, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	already_playing = FALSE

/datum/hud/human/proc/draw_re13_stam(datum/custom_hud/ui_datum)
	re13_stam = new /atom/movable/screen/re13_stam()
	re13_stam.icon = ui_datum.ui_style_icon
	re13_stam.screen_loc = "CENTER,CENTER"
	infodisplay += re13_stam

/atom/movable/screen/re13_stam
	name = "current stamina"
	icon_state = "re13stam_0"
	alpha = 0
	mouse_opacity = FALSE
	var/already_playing = FALSE

/atom/movable/screen/re13_stam/proc/show_stat(mob/living/carbon/human/user)
	if(user && user.hud_used)
		if(user.re13_player)
			icon_state = "re13stam_[user.re13_stam]"

			if(!already_playing)
				already_playing = TRUE

				animate(src, alpha = 255, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
				animate(src, transform = matrix(-8, 0, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)

/atom/movable/screen/re13_stam/proc/hide_stat()
	animate(src, alpha = 0, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
	animate(src, transform = matrix(0, 0, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	already_playing = FALSE
