class_name FinishedContainer extends VBoxContainer

signal done_button_pressed


func _on_done_button_pressed() -> void:
	done_button_pressed.emit()
