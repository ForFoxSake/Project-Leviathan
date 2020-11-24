/datum/computer_file/program/uplink
	filename = "taxquickly"
	filedesc = "TaxQuickly 6"
	program_icon_state = "uplink"
	extended_desc = "An online tax filing software. It is a few years out of date."
	size = 0 // it is cloud based
	requires_ntnet = 0
	available_on_ntnet = 0
	usage_flags = PROGRAM_PDA
	nanomodule_path = /datum/nano_module/program/uplink
	var/authenticated = FALSE

/datum/nano_module/program/uplink
	name = "TaxQuickly 6"
	var/error = FALSE
	var/stored_login = ""


/datum/nano_module/program/uplink/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["login"])
		log_in()
		return 1

	if(href_list["logout"])
		log_out()
		return 1

	if(href_list["back"])
		error = FALSE
		return 1

	if(href_list["edit_login"])
		var/newlogin = sanitize(input(usr,"Enter login", "Login", stored_login), 100)
		if(newlogin)
			stored_login = newlogin
		else
			stored_login = ""
		return 1

	if(href_list["resume"])
		var/obj/item/modular_computer/computer = nano_host()
		SSnanoui.close_user_uis(usr, src)
		computer.hidden_uplink.trigger(usr)
		return 1
	return 1

/datum/nano_module/program/uplink/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = host.initial_data()
	var/datum/computer_file/program/uplink/PRG = program
	data["error"] = error
	data["stored_login"] = stored_login
	data["authenticated"] = PRG.authenticated

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "taxquickly.tmpl", "TaxQuickly 6", 450, 600, state = state)
		if(host.update_layout())
			ui.auto_update_layout = TRUE
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(TRUE)

/datum/nano_module/program/uplink/proc/log_in()
	var/obj/item/modular_computer/computer = nano_host()
	var/datum/computer_file/program/uplink/PRG = computer.active_program
	if(!stored_login && computer?.card_slot?.stored_card && computer.card_slot.stored_card.associated_account_number)
		stored_login = computer.card_slot.stored_card.associated_account_number
	if(computer.hidden_uplink && computer.trigger_code && computer.hidden_uplink.check_trigger(usr,stored_login,computer.trigger_code))
		PRG.authenticated = TRUE
		error = FALSE
		SSnanoui.close_user_uis(usr, src)
		computer.hidden_uplink.trigger(usr)
	else
		error = TRUE

/datum/nano_module/program/uplink/proc/log_out()
	stored_login = ""
	var/datum/computer_file/program/uplink/PRG = program
	PRG.authenticated = FALSE