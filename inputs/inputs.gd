class_name InputsContainer extends VBoxContainer

signal settings_button_pressed
signal timer_start_button_pressed

const CONFIRM_TEXT = "Are you sure that's how long you want to work?"
const NO_INPUT_TEXT = "You haven't entered a time."

var hours: float = 0
var minutes: float = 0
var seconds: float = 0
var state_machine: StateMachine

@onready var time_box_hours: TimeBox = %TimeBoxHours
@onready var time_box_mins: TimeBox = %TimeBoxMins
@onready var time_box_secs: TimeBox = %TimeBoxSecs
@onready var time_error: Label = %TimeError

# states
@onready var states: Node = $States
@onready var default_input: InputState = $States/DefaultInput
@onready var confirm: InputState = $States/Confirm


func _ready() -> void:
	state_machine = StateMachine.new()
	state_machine.set_state(default_input)


func convert_minutes_to_seconds(minutes_to_convert: float) -> float:
	return minutes_to_convert * 60


func convert_hours_to_seconds(hours_to_convert: float) -> float:
	return hours_to_convert * 3600


func _on_settings_button_pressed() -> void:
	settings_button_pressed.emit()


func _on_start_button_pressed() -> void:
	hours = float(time_box_hours.text)
	minutes = float(time_box_mins.text)
	seconds = float(time_box_secs.text)

	if not hours and not minutes and not seconds:
		time_error.text = NO_INPUT_TEXT
		return

	if hours > 1 and state_machine.state != confirm:
		time_error.text = CONFIRM_TEXT
		state_machine.set_state(confirm)
		return

	time_error.text = ""
	var total_time_seconds: float = (
		convert_hours_to_seconds(hours)
		+ convert_minutes_to_seconds(minutes)
		+ seconds
	)
	EventBus.submit_time.emit(total_time_seconds)
	state_machine.set_state(default_input)
	timer_start_button_pressed.emit()
