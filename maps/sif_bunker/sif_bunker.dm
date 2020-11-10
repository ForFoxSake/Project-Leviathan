#if !defined(USING_MAP_DATUM)

	#include "sif_bunker_areas.dm"
	#include "sif_bunker_defines.dm"
	#include "sif.dm"
	#include "sif_bunker_elevator.dm"
	#include "sif_bunker_events.dm"
	#include "sif_bunker_presets.dm"
	#include "sif_bunker_shuttles.dm"

	#include "shuttles/crew_shuttles.dm"
	#include "shuttles/heist.dm"
	#include "shuttles/merc.dm"
	#include "shuttles/ninja.dm"
	#include "shuttles/ert.dm"

	//#include "loadout/loadout_accessories.dm"
	//#include "loadout/loadout_head.dm" // These are included with main project for now.
	//#include "loadout/loadout_suit.dm"
	//#include "loadout/loadout_uniform.dm"

	#include "datums/supplypacks/munitions.dm"
	#include "items/encryptionkey_sc.dm"
	#include "items/headset_sc.dm"
	//#include "items/clothing/sc_suit.dm"
	//#include "items/clothing/sc_under.dm"
	//#include "items/clothing/sc_accessory.dm"
	#include "job/outfits.dm"
	#include "structures/closets/engineering.dm"
	#include "structures/closets/medical.dm"
	#include "structures/closets/misc.dm"
	#include "structures/closets/research.dm"
	#include "structures/closets/security.dm"
	#include "turfs/outdoors.dm"
	#include "overmap/sectors.dm"

	#include "sif_bunker-1.dmm"
	#include "sif_bunker-2.dmm"
	#include "sif_bunker-3.dmm"
	#include "sif_bunker-4.dmm"
	#include "sif_bunker-5.dmm"
	#include "sif_bunker-6.dmm"
	#include "sif_bunker-7.dmm"
	#include "sif_bunker-8.dmm"

	#define USING_MAP_DATUM /datum/map/sif_bunker

	// todo: map.dmm-s here

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Sif Bunker

#endif