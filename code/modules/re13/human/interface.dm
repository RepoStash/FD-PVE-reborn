/datum/hud
	var/atom/movable/screen/re13_hp/re13_hp
	var/atom/movable/screen/re13_stam/re13_stam

	var/atom/movable/screen/re13_itemslot/re13_itemslot
	var/atom/movable/screen/re13_itemslot/second/re13_itemslot2
	var/atom/movable/screen/re13_itemslot/third/re13_itemslot3
	var/atom/movable/screen/re13_itemslot/fourth/re13_itemslot4
	var/atom/movable/screen/re13_itemslot/fifth/re13_itemslot5
	var/atom/movable/screen/re13_itemslot/sixth/re13_itemslot6

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
	human_mob.hud_used.re13_itemslot.show_stat(human_mob)
	human_mob.hud_used.re13_itemslot2.show_stat(human_mob)
	human_mob.hud_used.re13_itemslot3.show_stat(human_mob)
	human_mob.hud_used.re13_itemslot4.show_stat(human_mob)
	human_mob.hud_used.re13_itemslot5.show_stat(human_mob)
	human_mob.hud_used.re13_itemslot6.show_stat(human_mob)

/datum/keybinding/human/re13/inventory/up(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/human_mob = user.mob
	human_mob.hud_used.re13_hp.hide_stat(human_mob)
	human_mob.hud_used.re13_stam.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot2.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot3.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot4.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot5.hide_stat(human_mob)
	human_mob.hud_used.re13_itemslot6.hide_stat(human_mob)

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

/datum/hud/human/proc/draw_re13_itemslot(datum/custom_hud/ui_datum)
	re13_itemslot = new /atom/movable/screen/re13_itemslot()
	re13_itemslot.icon = ui_datum.ui_style_icon
	re13_itemslot.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot

/atom/movable/screen/re13_itemslot
	name = "slot 1"
	icon_state = "template" // ПОМЕНЯТЬ
	alpha = 0
	mouse_opacity = FALSE
	var/already_playing = FALSE
	var/pixel_x_offset = -32
	var/pixel_y_offset = 40

/atom/movable/screen/re13_itemslot/proc/show_stat(mob/living/carbon/human/user)
	if(user && user.hud_used)
		if(user.re13_player)

			if(!already_playing)
				already_playing = TRUE

				mouse_opacity = TRUE
				animate(src, alpha = 255, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
				animate(src, transform = matrix(pixel_x_offset, pixel_y_offset, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)

/atom/movable/screen/re13_itemslot/proc/hide_stat()
	animate(src, alpha = 0, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
	animate(src, transform = matrix(0, 0, MATRIX_TRANSLATE), time = 0.5 SECONDS, easing = SINE_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	already_playing = FALSE
	mouse_opacity = FALSE

/atom/movable/screen/re13_itemslot/clicked(mob/living/carbon/human/user, list/mods)
	if (..())
		return 1

	var/obj/item/W = user.get_active_hand()
	if(istype(W))
		var/start_loc = W.loc

		if(W == user.l_hand)
			user.l_hand = null
			user.update_inv_l_hand()
			for(var/item_actions in W.actions)
				var/datum/action/action = item_actions
				action.remove_from(user)

		else if(W == user.r_hand)
			user.r_hand = null
			user.update_inv_r_hand()
			for(var/item_actions in W.actions)
				var/datum/action/action = item_actions
				action.remove_from(user)

		W.screen_loc = null
		if(W.loc != user)
			W.pickup(user)
		W.forceMove(user)
		W.layer = ABOVE_HUD_LAYER
		W.plane = ABOVE_HUD_PLANE

		synchronize_with_mob(user, W)

		if(W.loc == start_loc && user.get_active_hand() != W)
			//They moved it from hands to an inv slot or vice versa. This will unzoom and unwield items -without- triggering lights.
			if(W.zoom)
				W.zoom(src)
			if(W.flags_item & TWOHANDED)
				W.unwield(src)

		return TRUE

	else
		remove_item_from_mob(user)

/atom/movable/screen/re13_itemslot/proc/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot1 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/proc/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot1)
		overlays -= image(user.re13_itemslot1.icon, user.re13_itemslot1.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot1)

		user.re13_itemslot1 = null

/datum/hud/human/proc/re13_itemslot2(datum/custom_hud/ui_datum)
	re13_itemslot2 = new /atom/movable/screen/re13_itemslot/second()
	re13_itemslot2.icon = ui_datum.ui_style_icon
	re13_itemslot2.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot2

/atom/movable/screen/re13_itemslot/second
	name = "slot 2"
	alpha = 0
	mouse_opacity = FALSE
	pixel_x_offset = -32
	pixel_y_offset = -40

/atom/movable/screen/re13_itemslot/second/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot2 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/second/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot2)
		overlays -= image(user.re13_itemslot2.icon, user.re13_itemslot2.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot2)

		user.re13_itemslot2 = null

/datum/hud/human/proc/re13_itemslot3(datum/custom_hud/ui_datum)
	re13_itemslot3 = new /atom/movable/screen/re13_itemslot/third()
	re13_itemslot3.icon = ui_datum.ui_style_icon
	re13_itemslot3.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot3

/atom/movable/screen/re13_itemslot/third
	name = "slot 3"
	alpha = 0
	mouse_opacity = FALSE
	pixel_x_offset = 0
	pixel_y_offset = 48

/atom/movable/screen/re13_itemslot/third/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot3 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/third/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot3)
		overlays -= image(user.re13_itemslot3.icon, user.re13_itemslot3.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot3)

		user.re13_itemslot3 = null

/datum/hud/human/proc/re13_itemslot4(datum/custom_hud/ui_datum)
	re13_itemslot4 = new /atom/movable/screen/re13_itemslot/fourth()
	re13_itemslot4.icon = ui_datum.ui_style_icon
	re13_itemslot4.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot4

/atom/movable/screen/re13_itemslot/fourth
	name = "slot 4"
	alpha = 0
	mouse_opacity = FALSE
	pixel_x_offset = 0
	pixel_y_offset = -48

/atom/movable/screen/re13_itemslot/fourth/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot4 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/fourth/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot4)
		overlays -= image(user.re13_itemslot4.icon, user.re13_itemslot4.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot4)

		user.re13_itemslot4 = null

/datum/hud/human/proc/re13_itemslot5(datum/custom_hud/ui_datum)
	re13_itemslot5 = new /atom/movable/screen/re13_itemslot/fifth()
	re13_itemslot5.icon = ui_datum.ui_style_icon
	re13_itemslot5.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot5

/atom/movable/screen/re13_itemslot/fifth
	name = "slot 5"
	alpha = 0
	mouse_opacity = FALSE
	pixel_x_offset = 32
	pixel_y_offset = 40

/atom/movable/screen/re13_itemslot/fifth/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot5 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/fifth/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot5)
		overlays -= image(user.re13_itemslot5.icon, user.re13_itemslot5.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot5)

		user.re13_itemslot5 = null

/datum/hud/human/proc/re13_itemslot6(datum/custom_hud/ui_datum)
	re13_itemslot6 = new /atom/movable/screen/re13_itemslot/sixth()
	re13_itemslot6.icon = ui_datum.ui_style_icon
	re13_itemslot6.screen_loc = "CENTER,CENTER"
	infodisplay += re13_itemslot6

/atom/movable/screen/re13_itemslot/sixth
	name = "slot 6"
	alpha = 0
	mouse_opacity = FALSE
	pixel_x_offset = 32
	pixel_y_offset = -40

/atom/movable/screen/re13_itemslot/sixth/synchronize_with_mob(mob/living/carbon/human/user, obj/item/holded)
	user.re13_itemslot6 = holded
	overlays += image(holded.icon, holded.icon_state)

/atom/movable/screen/re13_itemslot/sixth/remove_item_from_mob(mob/living/carbon/human/user)
	if(user.re13_itemslot6)
		overlays -= image(user.re13_itemslot6.icon, user.re13_itemslot6.icon_state)
		user.put_in_any_hand_if_possible(user.re13_itemslot6)

		user.re13_itemslot6 = null
