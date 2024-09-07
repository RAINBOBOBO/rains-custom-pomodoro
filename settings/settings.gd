class_name SettingsContainer extends VBoxContainer

signal settings_complete
signal sound_names_requested

var state_machine: StateMachine

# containers
@export var containers: Control
@export var audio_container: AudioContainer

# states
@export var states: Node
@export var audio: AudioSettingsState


func _ready() -> void:
	for settings_state in states.get_children():
		setup_state(settings_state)

	state_machine = StateMachine.new()
	set_state(audio)


func exit_settings() -> void:
	settings_complete.emit()


func hide_all() -> void:
	for container in containers.get_children():
		container.visible = false


func set_sound_names(sound_names: Array[String]) -> void:
	audio_container.set_sound_names(sound_names)


func set_state(next_state: SettingsState) -> void:
	hide_all()
	state_machine.set_state(next_state)


func setup_state(settings_state: SettingsState) -> void:
	settings_state.state_manager = self
	settings_state.setup_settings_state()


func _on_escape_pressed() -> void:
	exit_settings()
