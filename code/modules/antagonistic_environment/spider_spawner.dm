/obj/structure/spiderling_spawner
	name = "spider infestation tracker"
	desc = "This is the spider infestation tracker. Current round stats are:"
	icon = 'icons/mob/animal.dmi'
	icon_state = "nurse"
	density = 0
	anchored = 1
	plane = PLANE_GHOSTS // Ghost object!
	var/lastcount_spiderlings = 0
	var/lastcount_spiders = 0
	var/lastcount_time = 0
	var/spider_probability = 20
	var/spider_limit = 40
	var/spiderling_type = /obj/effect/spider/spiderling
	var/wait_count = 30 SECONDS
	var/wait_length = 10 MINUTES
	var/wait_until = 0

/obj/structure/spiderling_spawner/New()
	wait_until = world.time + wait_length
	START_PROCESSING(SSobj, src)

/obj/structure/spiderling_spawner/Destroy()
	STOP_PROCESSING(SSobj, src)

/obj/structure/spiderling_spawner/examine()
	. = ..()
	. += "<span class='danger'>[count_spiders()]</span> live spiders, and [lastcount_spiderlings] active spiderlings."
	var/seconds = round((wait_until - world.time) / 10)
	if(seconds > 59)
		var/minutes = round(seconds / 60)
		seconds = seconds - (minutes * 60)
		if (minutes > 59)
			var/hours = round(minutes / 60)
			minutes = minutes - (hours * 60)
			. += "[hours] hour\s, [minutes] minute\s and [seconds] second\s until next spiderling."
		else
			. += "[minutes] minute\s and [seconds] second\s until next spiderling."
	else
		if(seconds < 5)
			. += "<span class='danger'>[seconds]</span> second\s until next spiderling."
		else
			. += "[seconds] second\s until next spiderling."
	return .

/obj/structure/spiderling_spawner/process()
	if(world.time < wait_until) // We're waiting on a timer, no need to do anything.
		return
	else if (wait_length < 0) // We've been manually paused by var-edit!
		return

	wait_until = world.time + wait_length

	if(count_spiders() + lastcount_spiderlings > spider_limit)
		return
	if (prob(spider_probability))
		var/list/obj/machinery/atmospherics/unary/vent_pump/vents = list()
		for(var/obj/machinery/atmospherics/unary/vent_pump/on/pump in world) // Grab a list of "on" vents, because those probably aren't special-area vents.
			if(pump.z == src.z)
				vents.Add(pump)
		var/list/obj/machinery/atmospherics/unary/vent_pump/chosen_vent = pick(vents)
		var/obj/effect/spider/spiderling/spiderling = new spiderling_type(chosen_vent, src)
		spiderling.entry_vent = chosen_vent

/obj/structure/spiderling_spawner/proc/count_spiders() // This is costly, and doesn't need to be ultra accurate, so lets cache!
	if(world.time > lastcount_time + wait_count)
		lastcount_time = world.time
		lastcount_spiders = 0
		for(var/mob/living/simple_mob/animal/giant_spider/spider in world)
			if(spider.stat != DEAD)
				lastcount_spiders++
		lastcount_spiderlings = 0
		for(var/obj/effect/spider/spiderling/spiderling in world)
			if(spiderling.amount_grown >= 0)
				lastcount_spiderlings++

	return lastcount_spiders