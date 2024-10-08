class_name AudioContainer extends VBoxContainer

signal back_pressed

@export var alarm_sound_option: OptionButton
@export var sample_button: Button
@export var stop_button: Button
@export var volume_slider: HSlider
@export var volume_label: Label

var sound_name_to_id: Array[SoundNameMap]


func _ready() -> void:
	alarm_sound_option.item_selected.connect(_on_alarm_sound_id_pressed)
	var audio_settings: Dictionary = ConfigFileHandler.load_settings(
		ConfigFileHandler.ConfigSections.AUDIO
	)
	alarm_sound_option.name = audio_settings.timer_complete_sound
	volume_label.text = str(int(audio_settings.Master_volume * 100))


func get_sound_name_by_id(search_id: int) -> String:
	var sound_name: String = "NOT FOUND"
	for current_sound_name_map in sound_name_to_id:
		if current_sound_name_map.sound_id == search_id:
			sound_name = current_sound_name_map.sound_name
			break

	return sound_name


func set_sound_names(sound_names: Array[String]) -> void:
	var current_id: int = 0
	for sound_name in sound_names:
		sound_name_to_id.append(
			SoundNameMap.new(sound_name, current_id)
		)
		alarm_sound_option.add_item(sound_name, current_id)
		current_id += 1


func _on_alarm_sound_id_pressed(id: int) -> void:
	var sound_name: String = get_sound_name_by_id(id)
	alarm_sound_option.name = sound_name
	ConfigFileHandler.save_setting(
		ConfigFileHandler.ConfigSections.AUDIO,
		"timer_complete_sound",
		sound_name,
	)

	EventBus.stop_audio_requested.emit()
	reset_alarm_sound_buttons()


func _on_sample_button_pressed() -> void:
	EventBus.play_audio_requested.emit()
	_swap_alarm_sound_buttons()


func _on_stop_button_pressed() -> void:
	EventBus.stop_audio_requested.emit()
	_swap_alarm_sound_buttons()


func reset_alarm_sound_buttons() -> void:
	sample_button.visible = true
	stop_button.visible = false


func _swap_alarm_sound_buttons() -> void:
	sample_button.visible = not sample_button.visible
	stop_button.visible = not stop_button.visible


func _on_volume_slider_value_changed(value: float) -> void:
	volume_label.text = str(int(value * 100))


class SoundNameMap:
	var sound_name: String
	var sound_id: int

	func _init(p_name: String, p_id: int) -> void:
		sound_name = p_name
		sound_id = p_id
