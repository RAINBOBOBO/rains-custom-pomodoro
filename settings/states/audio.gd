extends SettingsState


func enter() -> void:
	super()
	container.reset_alarm_sound_buttons()


func exit() -> void:
	EventBus.stop_audio_requested.emit()
