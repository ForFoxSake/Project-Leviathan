// Lightspot effects, for more atmospheric lighting.
/obj/effect/effect/light
	name = "light"
	icon = 'icons/effects/64x64.dmi'
	layer = ABOVE_WINDOW_LAYER
	opacity = FALSE
	mouse_opacity = FALSE
	icon_state = "nothing"
	pixel_x = -16
	pixel_y = -16
	var/radius = 3
	var/brightness = 2

/obj/effect/effect/light/New(var/newloc, var/radius, var/brightness, var/light_color)
	..()
	src.radius = radius
	src.brightness = brightness
	src.light_color = light_color
	set_light(radius,brightness,light_color)
	color = light_color

/obj/effect/effect/light/set_light(l_range, l_power, l_color)
	..()
	radius = l_range
	brightness = l_power
	light_color = l_color
	color = l_color