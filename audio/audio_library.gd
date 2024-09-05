class_name AudioLibrary extends Node

signal audio_finished

var sound: AudioStreamPlayer
var selected_sound: String


func _ready() -> void:
	EventBus.play_audio_requested.connect(_on_play_audio_requested)
	EventBus.play_looping_audio_requested.connect(_on_play_looping_audio_requested)
	EventBus.stop_audio_requested.connect(stop_sound)
	refresh_current_selected_sound()


func get_all_sound_names() -> Array[String]:
	var all_sound_names: Array[String] = []
	for sound_node in get_children():
		all_sound_names.append(sound_node.name)

	return all_sound_names


func refresh_current_selected_sound() -> void:
	var audio_settings: Dictionary = ConfigFileHandler.load_settings(
		ConfigFileHandler.ConfigSections.AUDIO
	)
	selected_sound = audio_settings.timer_complete_sound


func play_sound(sound_name: String) -> void:
	sound = get_node_or_null(sound_name)
	if not is_instance_valid(sound):
		push_warning("No sound found by the name " + sound_name)
		return

	sound.play()
	sound.finished.connect(_on_finished)


func stop_sound() -> void:
	if not is_instance_valid(sound):
		return

	sound.stop()
	sound.finished.disconnect(_on_finished)
	sound = null


func _on_finished() -> void:
	sound.finished.disconnect(_on_finished)
	sound = null
	audio_finished.emit()


func _on_play_audio_requested() -> void:
	refresh_current_selected_sound()
	play_sound(selected_sound)


func _on_play_looping_audio_requested() -> void:
	refresh_current_selected_sound()
	play_sound(selected_sound)
	await audio_finished
	_on_play_looping_audio_requested()
