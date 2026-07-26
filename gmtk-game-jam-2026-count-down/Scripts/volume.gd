extends HSlider

@onready var bus_index : int = AudioServer.get_bus_index("Master")

var grabber_on = preload("res://Assets/Test/smaller/icon_sound.png")
var grabber_off = preload("res://Assets/Test/smaller/icon_sound_disabled.png")

func _ready() -> void:
	await get_tree().process_frame
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _process(_delta: float) -> void:
	if value == 0:
		add_theme_icon_override("grabber", grabber_off)
		add_theme_icon_override("grabber_highlight", grabber_off)
	else:
		add_theme_icon_override("grabber", grabber_on)
		add_theme_icon_override("grabber_highlight", grabber_on)

func check_vol() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
