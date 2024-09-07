extends Node

enum ConfigSections {AUDIO}

@export var timer_complete_sound: String

var config = ConfigFile.new()


func _ready() -> void:
	if !FileAccess.file_exists(Paths.SETTINGS_FILE_PATH):
		_set_config_defaults()
	else:
		config.load(Paths.SETTINGS_FILE_PATH)


func _get_section_setting_string(settings_section: ConfigSections) -> String:
	var settings_section_string: String
	match settings_section:
		ConfigSections.AUDIO:
			settings_section_string = "audio"

	return settings_section_string


func _set_config_defaults() -> void:
	config.set_value("audio", "timer_complete_sound", "MorningAlarm")
	config.set_value("audio", "Master_volume", 1)
	config.set_value("audio", "music_volume", 1)
	config.set_value("audio", "sfx_volume", 1)

	config.save(Paths.SETTINGS_FILE_PATH)


func save_setting(settings_section: ConfigSections, key: String, value) -> void:
	var settings_section_string: String = (
		_get_section_setting_string(settings_section)
	)
	config.set_value(settings_section_string, key, value)
	config.save(Paths.SETTINGS_FILE_PATH)


func load_settings(settings_section: ConfigSections) -> Dictionary:
	var settings_section_string: String = (
		_get_section_setting_string(settings_section)
	)
	var settings: Dictionary = {}
	for key in config.get_section_keys(settings_section_string):
		settings[key] = config.get_value(settings_section_string, key)

	return settings
