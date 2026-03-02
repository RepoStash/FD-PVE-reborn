/obj/structure/bed/chair/remote
	name = "virtual reality centre"
	desc = "A comfortable chair with full audio-visual transposition centres."
	icon_state = "pilot_chair"
	var/list/remote_network // Which network does this remote control belong to?

/obj/structure/bed/chair/remote/update_icon()
	return

/obj/structure/bed/chair/remote/buckle_mob(mob/user)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.old_mob)
			to_chat(H, SPAN_WARNING("The chair rejects you! You cannot recursively control bodies."))
			return

// Return to our body in the unfortunate event that we get unbuckled while plugged in
/obj/structure/bed/chair/remote/unbuckle(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.body_return()
	..()
