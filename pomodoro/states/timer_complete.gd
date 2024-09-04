extends PomodoroState

var audio_library: AudioLibrary
var finished_button_pressed: Signal
var finished_section: VBoxContainer
var timer_complete_sound: String = "MorningAlarm"


func enter() -> void:
	finished_section.visible = true
	audio_library.play_sound(timer_complete_sound)


func inject_dependencies(
	p_finished_button_pressed: Signal,
	p_finished_section: VBoxContainer,
	p_audio_library: AudioLibrary,
) -> void:
	finished_button_pressed = p_finished_button_pressed
	finished_button_pressed.connect(_on_finished_button_pressed)

	finished_section = p_finished_section

	audio_library = p_audio_library
	audio_library.audio_finished.connect(_on_audio_finished)


func _on_audio_finished() -> void:
	audio_library.play_sound(timer_complete_sound)


func _on_finished_button_pressed() -> void:
	audio_library.stop_sound()
	is_complete = true
