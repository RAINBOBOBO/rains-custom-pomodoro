class_name AudioLibrary extends Node

signal audio_finished

var sound: AudioStreamPlayer


func get_all_sound_names() -> Array[String]:
	var all_sound_names: Array[String] = []
	for sound_node in get_children():
		all_sound_names.append(sound_node.name)

	return all_sound_names


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


func _on_finished() -> void:
	sound.finished.disconnect(_on_finished)
	sound = null
	audio_finished.emit()
