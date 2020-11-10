//////////////////////////////////
//		Head of Operations
//////////////////////////////////
/datum/job/hos
	title = "Head of Operations"
	flag = HOS
	departments_managed = list(DEPARTMENT_SECURITY)
	departments = list(DEPARTMENT_SECURITY, DEPARTMENT_COMMAND)
	sorting_order = 2
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Commanding Officer"
	selection_color = "#8E2929"
	req_admin_notify = 1
	economic_modifier = 10
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimum_character_age = 25
	minimal_player_age = 14

	outfit_type = /decl/hierarchy/outfit/job/security/hos
	job_description = "	The Head of Operations manages the operations of the station, keeping the station safe and coordinating response against threats. They are expected to \
						keep the other Department Heads, and the rest of the crew, aware of developing situations that may be a threat. If necessary, the HoO may \
						perform the duties of absent Security roles."
	alt_titles = list(
//		"Security Commander" = /datum/alt_title/sec_commander,
		"Chief of Operations" = /datum/alt_title/sec_chief)

/* // Head of Operations Alt Titles
/datum/alt_title/sec_commander
	title = "Security Commander"
*/

/datum/alt_title/sec_chief
	title = "Chief of Operations"

//////////////////////////////////
//			Warden
//////////////////////////////////
/datum/job/warden
	title = "Warden"
	flag = WARDEN
	departments = list(DEPARTMENT_SECURITY)
	sorting_order = 1
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Head of Operations"
	selection_color = "#601C1C"
	economic_modifier = 5
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 5

	outfit_type = /decl/hierarchy/outfit/job/security/warden
	job_description = "The Warden watches over the physical Security Department, making sure the Brig and Armoury are secure and in order at all times. They oversee \
						prisoners that have been processed and brigged, and are responsible for their well being. The Warden is also in charge of distributing \
						Armoury gear in a crisis, and retrieving it when the crisis has passed. In an emergency, the Warden may be called upon to direct the \
						Security Department as a whole."

//////////////////////////////////
//			Detective
//////////////////////////////////
/datum/job/detective
	title = "Detective"
	flag = DETECTIVE
	departments = list(DEPARTMENT_SECURITY)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Head of Operations"
	selection_color = "#601C1C"
	access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels, access_eva, access_external_airlocks)
	minimal_access = list(access_security, access_sec_doors, access_forensics_lockers, access_morgue, access_maint_tunnels, access_eva, access_external_airlocks)
	economic_modifier = 5
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/security/detective
	job_description = "A Detective works to help Security find criminals who have not properly been identified, through interviews and forensic work. \
						For crimes only witnessed after the fact, or those with no survivors, they attempt to piece together what they can from pure evidence."
	alt_titles = list("Forensic Technician" = /datum/alt_title/forensic_tech)

// Detective Alt Titles
/datum/alt_title/forensic_tech
	title = "Forensic Technician"
	title_blurb = "A Forensic Technician works more with hard evidence and labwork than a Detective, but they share the purpose of solving crimes."
	title_outfit = /decl/hierarchy/outfit/job/security/detective/forensic

//////////////////////////////////
//		Outpost Guard
//////////////////////////////////
/datum/job/guard
	title = "Guard"
	flag = GUARD
	departments = list(DEPARTMENT_SECURITY)
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Head of Operations"
	selection_color = "#601C1C"
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/security/guard
	job_description = "A Guard is concerned with maintaining the safety and security of the station as a whole, dealing with external threats and \
						apprehending criminals. A Guard is responsible for the health, safety, and processing of any prisoner they arrest. \
						No one is above the Law, not Security or Command."
	alt_titles = list("Patrolman" = /datum/alt_title/patrolman,
					"Junior Guard" = /datum/alt_title/junior_guard)

// Outpost Guard Alt Titles
/datum/alt_title/junior_guard
	title = "Junior Guard"
	title_blurb = "A Junior Guard is an inexperienced Outpost Guard. They likely have training, but not experience, and are frequently \
					paired off with a more senior co-worker. Junior Guards may also be expected to take over the boring duties of other Guards \
					including patrolling the station or maintaining specific posts."

/datum/alt_title/patrolman
	title = "Patrolman"
