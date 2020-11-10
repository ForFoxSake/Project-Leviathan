/var/global/spacevines_spawned = 0

/datum/event/spacevine
	announceWhen	= 60

/datum/event/spacevine/start()
	spacevine_infestation(typesof(/area/hallway))
	spacevines_spawned = 1

/datum/event/spacevine/announce()
	level_seven_announcement()


/datum/event/spacevine/maint/start()
	spacevine_infestation(typesof(/area/maintenance))
	spacevines_spawned = 1

/datum/event/spacevine/maint/announce()
	return // This one is sneaky quiet.
