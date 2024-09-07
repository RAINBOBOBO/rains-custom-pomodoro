extends HSlider

@export var bus_name: String = "Master"

var bus_index: int


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)

	var audio_settings: Dictionary = ConfigFileHandler.load_settings(
		ConfigFileHandler.ConfigSections.AUDIO
	)
	var setting_key: String = bus_name + "_volume"
	value = audio_settings.get(setting_key)



func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(new_value)
	)

	var setting_key: String = bus_name + "_volume"
	ConfigFileHandler.save_setting(
		ConfigFileHandler.ConfigSections.AUDIO,
		setting_key,
		value,
	)
