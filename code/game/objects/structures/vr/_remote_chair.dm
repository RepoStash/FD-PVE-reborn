/obj/structure/bed/chair/remote
	name = "virtual reality centre"
	desc = "A comfortable chair with full audio-visual transposition centres."
	icon_state = "pilot_chair"
	var/list/remote_network // Which network does this remote control belong to?

/obj/structure/bed/chair/remote/update_icon()
	return

/obj/structure/bed/chair/remote/buckle_mob(mob/user)
	..()
	if(!HAS_TRAIT(user, TRAIT_VR_USER))
		to_chat(user, SPAN_WARNING("You don't know how to use this!"))
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.old_mob)
			to_chat(H, SPAN_WARNING("The chair rejects you! You cannot recursively control bodies."))
			return
		SSvirtualreality.robot_selection(H, remote_network)

// Return to our body in the unfortunate event that we get unbuckled while plugged in
/obj/structure/bed/chair/remote/unbuckle(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.body_return()
	..()
