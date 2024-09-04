extends VBoxContainer

signal settings_complete

var state_machine: StateMachine

# containers
@onready var menu_container: VBoxContainer = $MenuContainer
@onready var audio_container: VBoxContainer = $AudioContainer

# states
@onready var states: Node = $States
@onready var audio: SettingsState = $States/Audio
@onready var menu: SettingsState = $States/Menu


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


func set_state(next_state: SettingsState) -> void:
	hide_all()
	state_machine.set_state(next_state)


func setup_state(settings_state: SettingsState) -> void:
	settings_state.state_manager = self
	settings_state.setup_settings_state()
