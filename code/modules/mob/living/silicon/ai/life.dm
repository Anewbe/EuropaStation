/mob/living/silicon/ai/Life()
	if (src.stat == DEAD)
		return

	if (src.stat!=CONSCIOUS)
		src.cameraFollow = null
		src.reset_view(null)

	src.updatehealth()

	if (!hardware_integrity() || !backup_capacitor())
		death()
		return

	// If our powersupply object was destroyed somehow, create new one.
	if(!psupply)
		create_powersupply()

	handle_stunned()	// Handle EMP-stun
	set_lying(0)		// Handle lying down

	malf_process()

	if(APU_power && (hardware_integrity() < 50))
		src << "<span class='notice'><b>APU GENERATOR FAILURE! (System Damaged)</b></span>"
		stop_apu(1)

	// We aren't shut down, and we lack external power. Try to fix it using the restoration routine.
	if (!self_shutdown && !has_power(0))
		// AI's restore power routine is not running. Start it automatically.
		if(aiRestorePowerRoutine == AI_RESTOREPOWER_IDLE)
			aiRestorePowerRoutine = AI_RESTOREPOWER_STARTING
			spawn(0)
				handle_power_failure()

	update_power_usage()
	handle_power_oxyloss()
	update_sight()

	process_queued_alarms()
	handle_regular_hud_updates()
	switch(src.sensor_mode)
		if (SEC_HUD)
			process_sec_hud(src,0,src.eyeobj)
		if (MED_HUD)
			process_med_hud(src,0,src.eyeobj)


/mob/living/silicon/ai/updatehealth()
	if(status_flags & GODMODE)
		health = 100
		stat = CONSCIOUS
		setOxyLoss(0)
	else
		health = 100 - getFireLoss() - getBruteLoss() // Oxyloss is not part of health as it represents AIs backup power. AI is immune against ToxLoss as it is machine.

/mob/living/silicon/ai/rejuvenate()
	..()
	add_ai_verbs(src)

/mob/living/silicon/ai/update_sight()
	if(!has_power() || self_shutdown)
		updateicon()
		overlay_fullscreen("blind", /obj/screen/fullscreen/blind)
		sight = sight&~SEE_TURFS
		sight = sight&~SEE_MOBS
		sight = sight&~SEE_OBJS
		see_in_dark = 0
		see_invisible = SEE_INVISIBLE_LIVING
	else
		clear_fullscreen("blind")
		update_dead_sight()