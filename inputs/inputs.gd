extends VBoxContainer

const CONFIRM_TEXT = "Are you sure that's how long you want to work?"
const NO_INPUT_TEXT = "You haven't entered a time."

var hours: float = 0
var minutes: float = 0
var seconds: float = 0

@onready var time_box_hours: TimeBox = %TimeBoxHours
@onready var time_box_mins: TimeBox = %TimeBoxMins
@onready var time_box_secs: TimeBox = %TimeBoxSecs
@onready var time_error: Label = %TimeError
@onready var pomodoro: Pomodoro = $"../../../.."


func convert_minutes_to_seconds(minutes_to_convert: float) -> float:
	return minutes_to_convert * 60


func convert_hours_to_seconds(hours_to_convert: float) -> float:
	return hours_to_convert * 3600


func _on_start_button_pressed() -> void:
	hours = float(time_box_hours.text)
	minutes = float(time_box_mins.text)
	seconds = float(time_box_secs.text)

	if not hours and not minutes and not seconds:
		time_error.text = NO_INPUT_TEXT
		return

	if hours > 1 and pomodoro.state != pomodoro.States.CONFIRM:
		time_error.text = CONFIRM_TEXT
		pomodoro.change_state.emit(pomodoro.States.CONFIRM)
		return

	time_error.text = ""
	var total_time_seconds: float = (
		convert_hours_to_seconds(hours)
		+ convert_minutes_to_seconds(minutes)
		+ seconds
	)
	EventBus.submit_time.emit(total_time_seconds)
	pomodoro.change_state.emit(pomodoro.States.WORK)
