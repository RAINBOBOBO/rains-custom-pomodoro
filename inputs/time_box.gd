class_name TimeBox extends LineEdit


func _on_focus_exited() -> void:
	if not text.is_valid_int():
		text = ""
