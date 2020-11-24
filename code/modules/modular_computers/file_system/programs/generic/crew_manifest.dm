/datum/computer_file/program/crew_manifest
	filename = "crewmanifest"
	filedesc = "Crew Manifest"
	extended_desc = "This program allows access to the manifest of active crew."
	program_icon_state = "generic"
	program_key_state = "generic_key"
	size = 4
	requires_ntnet = 1
	available_on_ntnet = 1
	nanomodule_path = /datum/nano_module/crew_manifest
	usage_flags = PROGRAM_ALL

/datum/nano_module/crew_manifest
	name = "Crew Manifest"

/datum/nano_module/crew_manifest/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, state = default_state)
	var/list/data = host.initial_data()
	data_core.get_manifest_list()
	data["manifest"] = PDA_Manifest

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "crew_manifest.tmpl", name, 450, 600, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()