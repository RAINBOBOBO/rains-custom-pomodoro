class_name Pomodoro extends Node2D

signal change_state(new_state: States)
signal submit_time(time_seconds: int)

enum States {TIME_INPUT, CONFIRM, WORK, TIMER_COMPLETE}

var state: States = States.TIME_INPUT
var prev_state: States = state


func _ready() -> void:
	change_state.connect(_on_state_change)


func _on_state_change(new_state: States) -> void:
	prev_state = state
	state = new_state


func _on_submit_time(time_seconds: int) -> void:
	pass # Replace with function body.
