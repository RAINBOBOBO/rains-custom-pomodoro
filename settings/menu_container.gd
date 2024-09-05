class_name SettingsMenuContainer extends VBoxContainer

signal audio_pressed
signal back_pressed


func _on_audio_button_pressed() -> void:
	audio_pressed.emit()


func _on_back_button_pressed() -> void:
	back_pressed.emit()
