class_name Finished extends VBoxContainer

signal done_button_pressed


func _on_done_button_pressed() -> void:
	done_button_pressed.emit()
