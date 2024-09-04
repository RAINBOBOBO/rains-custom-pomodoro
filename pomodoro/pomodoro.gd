class_name Pomodoro extends Node2D

var state_machine:= StateMachine.new()

@onready var timer_display: VBoxContainer = %TimerDisplay
@onready var finished: VBoxContainer = %Finished
@onready var inputs: VBoxContainer = %Inputs
@onready var pomodoro_timer: PomodoroTimer = %PomodoroTimer
@onready var audio_library: AudioLibrary = %AudioLibrary
@onready var settings_container: VBoxContainer = %SettingsContainer

# states
@onready var states: Node = $States
@onready var time_input: PomodoroState = $States/TimeInput
@onready var work: PomodoroState = $States/Work
@onready var timer_complete: PomodoroState = $States/TimerComplete
@onready var settings: PomodoroState = $States/Settings


func _ready() -> void:
	pomodoro_timer.timer_complete.connect(_on_timer_complete)

	for pomodoro_state in states.get_children():
		pomodoro_state.state_manager = self

	_inject_dependencies()
	timer_display.inject_timer(pomodoro_timer)

	state_machine.set_state(time_input)


func _physics_process(_delta: float) -> void:
	state_machine.state.physics_update_branch()


func _process(_delta: float) -> void:
	if state_machine.state.is_complete:
		choose_next_state()

	state_machine.state.update_branch()


func choose_next_state() -> void:
	hide_all()

	match state_machine.state:
		time_input:
			set_next_state_for(time_input)
		work:
			state_machine.set_state(time_input)
		timer_complete:
			state_machine.set_state(time_input)
		settings:
			state_machine.set_state(time_input)


func hide_all() -> void:
	inputs.visible = false
	timer_display.visible = false
	finished.visible = false


func set_next_state_for(current_state: PomodoroState) -> void:
	var next_state: PomodoroState = current_state.next_state
	state_machine.set_state(next_state)


func _inject_dependencies() -> void:
	time_input.inject_dependencies(
		inputs.settings_button_pressed,
		inputs.timer_start_button_pressed,
		inputs,
	)
	work.inject_dependencies(
		timer_display.timer_stop_button_pressed,
		timer_display,
	)
	timer_complete.inject_dependencies(
		finished.done_button_pressed,
		finished,
		audio_library,
	)
	settings.inject_dependencies(
		settings_container.settings_complete,
		settings_container,
	)


func _on_timer_complete() -> void:
	hide_all()
	state_machine.set_state(timer_complete)
