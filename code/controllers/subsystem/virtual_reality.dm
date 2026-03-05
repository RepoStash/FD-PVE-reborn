/var/global/datum/controller/subsystem/virtualreality/SSvirtualreality

/datum/controller/subsystem/virtualreality
	name = "Virtual Reality"
	init_order = SS_INIT_HUMANS
	flags = SS_NO_FIRE

	// IPC BODIES
	var/list/robotnetworks = list("remoterobots", "remotexenos")
	var/list/robots = list()

/datum/controller/subsystem/virtualreality/New()
	NEW_SS_GLOBAL(SSvirtualreality)

/datum/controller/subsystem/virtualreality/Initialize()
	for(var/network in robotnetworks)
		robots[network] = list()
	..()

/datum/controller/subsystem/virtualreality/proc/add_robot(mob/living/robot, network)
	if(robot && network)
		robots[network] += robot

/datum/controller/subsystem/virtualreality/proc/remove_robot(mob/living/robot, network)
	if(robot && network)
		robots[network] -= robot

/mob/living/
	var/mob/living/vr_mob = null // In which mob is our mind
	var/mob/living/old_mob = null // Which mob is our old mob

/mob/living/carbon/verb/vr_return()
	set name = "Return to Body"
	set desc = "Returns you to your original body."
	set category = "IC"

	body_return()

// Return to our original body
/mob/living/carbon/proc/body_return()
	if(!vr_mob && !old_mob)
		return

	if(vr_mob)
		ckey = vr_mob.ckey
		vr_mob.remove_client_color_matrix("vr_effect", 1 SECONDS)
		vr_mob.clear_fullscreen("vr_effect", 0.5 SECONDS)
		vr_mob.ckey = null
		vr_mob.old_mob = null
		vr_mob = null
		to_chat(src, SPAN_NOTICE(FONT_SIZE_LARGE("System exited safely, we hope you enjoyed your stay.")))
	if(old_mob)
		old_mob.remove_client_color_matrix("vr_effect", 1 SECONDS)
		old_mob.clear_fullscreen("vr_effect", 0.5 SECONDS)
		old_mob.ckey = ckey
		ckey = null
		old_mob.vr_mob = null
		to_chat(old_mob, SPAN_NOTICE(FONT_SIZE_LARGE("System exited safely, we hope you enjoyed your stay.")))
		old_mob = null
	else
		to_chat(src, SPAN_ALERT(FONT_SIZE_LARGE("Interface error, you cannot exit the system at this time.")))

// Handles saving of the original mob and assigning the new mob
/datum/controller/subsystem/virtualreality/proc/mind_transfer(mob/living/M, mob/living/target)
	var/new_ckey = M.ckey
	target.old_mob = M
	M.vr_mob = target
	target.ckey = new_ckey
	M.ckey = "@[new_ckey]"
	target.verbs += /mob/living/carbon/proc/body_return

	target.languages = M.languages

	target.add_client_color_matrix("vr_effect", 99, color_matrix_multiply(color_matrix_saturation(0), color_matrix_from_string("#eeeeee")))
	target.overlay_fullscreen("vr_effect", /atom/movable/screen/fullscreen/flash/noise/nvg)
	playsound(target, 'sound/mecha/LongSyndiActivation.ogg', 50)
	to_chat(target, SPAN_NOTICE(FONT_SIZE_LARGE("Connection established, system suite active and calibrated.")))
	to_chat(target, SPAN_WARNING(FONT_SIZE_LARGE("To exit this mode, use the \"Return to Body\" verb in the IC tab.")))

/datum/controller/subsystem/virtualreality/proc/robot_selection(user, network)
	var/list/robot = list()
	robot["Return"] = null

	for(var/mob/living/R in robots[network])
		var/turf/T = get_turf(R)
		if(!T)
			continue
		if(R.client || R.ckey)
			continue
		if(R.stat == DEAD)
			continue
		robot[R.name] = R

	if(robot.len == 1)
		to_chat(user, SPAN_WARNING(FONT_SIZE_LARGE("No active remote robots are available.")))
		return

	var/desc = input("Please select a remote control robot to take over.", "Remote Robot Selection") in robot|null
	if(!desc)
		return

	mind_transfer(user, robot[desc])

	return
