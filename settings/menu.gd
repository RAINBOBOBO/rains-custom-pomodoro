class_name MenuSettingsState extends SettingsState


func enter() -> void:
	container.visible = true


func setup_settings_state() -> void:
	container = state_manager.menu_container
	container.audio_pressed.connect(_on_audio_pressed)
	container.back_pressed.connect(_on_back_pressed)


func _on_audio_pressed() -> void:
	state_manager.set_state(state_manager.audio)


func _on_back_pressed() -> void:
	state_manager.exit_settings()
