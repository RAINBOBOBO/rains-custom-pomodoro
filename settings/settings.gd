class_name SettingsContainer extends VBoxContainer

signal settings_complete
signal sound_names_requested

var state_machine: StateMachine
var first_time_setup: bool = false

# containers
@export var containers: Control
@export var audio_container: AudioContainer
@export var section_titles: VBoxContainer

# states
@export var states: Node
@export var audio: SettingsState
@export var video: SettingsState
@export var appearance: SettingsState
@export var personalization: SettingsState


func _ready() -> void:
	for settings_state in states.get_children():
		setup_state(settings_state)

	state_machine = StateMachine.new()
	set_state(audio)
	first_time_setup = true


func exit_settings() -> void:
	settings_complete.emit()


func hide_all() -> void:
	for container in containers.get_children():
		container.visible = false


func set_sound_names(sound_names: Array[String]) -> void:
	audio_container.set_sound_names(sound_names)


func set_state(next_state: SettingsState) -> void:
	hide_all()
	state_machine.set_state(next_state, true)
	section_titles.toggle_button(next_state.section_button)


func setup_state(settings_state: SettingsState) -> void:
	settings_state.state_manager = self


func _on_escape_pressed() -> void:
	EventBus.stop_audio_requested.emit()
	exit_settings()


# section buttons
func _on_audio_section_pressed() -> void:
	set_state(audio)


func _on_video_section_pressed() -> void:
	set_state(video)


func _on_appearance_section_pressed() -> void:
	set_state(appearance)


func _on_personalization_section_pressed() -> void:
	set_state(personalization)


func _on_section_titles_v_box_visibility_changed() -> void:
	if not first_time_setup:
		return

	section_titles.toggle_button(state_machine.state.section_button)
