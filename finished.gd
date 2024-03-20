class_name Finished extends VBoxContainer

@onready var pomodoro: Pomodoro = $"../../../.."

func _on_done_button_pressed() -> void:
	pomodoro.change_state.emit(Pomodoro.States.TIME_INPUT)
