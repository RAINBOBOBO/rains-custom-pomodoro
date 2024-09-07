class_name AudioSettingsState extends SettingsState


func enter() -> void:
	container.visible = true


func setup_settings_state() -> void:
	container = state_manager.audio_container
	container.back_pressed.connect(_on_back_pressed)


func _on_back_pressed() -> void:
	state_manager.set_state(state_manager.menu)
