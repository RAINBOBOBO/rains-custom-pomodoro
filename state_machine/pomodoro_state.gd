class_name PomodoroState extends State

var state_manager: Node2D
var next_state: PomodoroState


func _select_next_state(new_state: PomodoroState) -> void:
	next_state = new_state
	is_complete = true
