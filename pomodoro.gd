class_name Pomodoro extends Node2D

signal change_state(new_state: States)

enum States {TIME_INPUT, CONFIRM, WORK, TIMER_COMPLETE}

var state: States = States.TIME_INPUT
var prev_state: States = state

@onready var timer_display: VBoxContainer = %TimerDisplay
@onready var finished: VBoxContainer = %Finished
@onready var inputs: VBoxContainer = %Inputs
@onready var pomodoro_timer: PomodoroTimer = %PomodoroTimer


func _ready() -> void:
	change_state.connect(_on_state_change)


func hide_all() -> void:
	inputs.visible = false
	timer_display.visible = false
	finished.visible = false


func _on_state_change(new_state: States) -> void:
	if new_state == States.WORK:
		hide_all()
		timer_display.visible = true
	if new_state == States.TIMER_COMPLETE:
		hide_all()
		finished.visible = true
	if new_state == States.TIME_INPUT:
		hide_all()
		inputs.visible = true

	prev_state = state
	state = new_state
