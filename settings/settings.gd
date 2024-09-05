class_name SettingsContainer extends VBoxContainer

signal settings_complete
signal sound_names_requested

var state_machine: StateMachine

# containers
@onready var menu_container: SettingsMenuContainer = $MenuContainer
@onready var audio_container: AudioContainer = $AudioContainer

# states
@onready var states: Node = $States
@onready var menu: MenuSettingsState = $States/Menu
@onready var audio: AudioSettingsState = $States/Audio


func _ready() -> void:
	for settings_state in states.get_children():
		setup_state(settings_state)

	state_machine = StateMachine.new()
	set_state(menu)


func exit_settings() -> void:
	settings_complete.emit()


func hide_all() -> void:
	menu_container.visible = false
	audio_container.visible = false


func set_sound_names(sound_names: Array[String]) -> void:
	audio_container.set_sound_names(sound_names)


func set_state(next_state: SettingsState) -> void:
	hide_all()
	state_machine.set_state(next_state)


func setup_state(settings_state: SettingsState) -> void:
	settings_state.state_manager = self
	settings_state.setup_settings_state()
