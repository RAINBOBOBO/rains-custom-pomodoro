class_name PomodoroTimer extends Timer

var total_seconds: float = 0
var elapsed_seconds: float = 0
var percent_complete: float = 0
var seconds_remaining: float = 0

@onready var pomodoro: Pomodoro = $".."


func _ready() -> void:
	EventBus.submit_time.connect(_on_submit_time)
	EventBus.reset_pomodoro.connect(_on_reset)


func reset_timer() -> void:
	total_seconds = 0
	elapsed_seconds = 0
	percent_complete = 0
	seconds_remaining = 0
	paused = false


func _on_reset() -> void:
	reset_timer()


func _on_timeout() -> void:
	elapsed_seconds += 1
	percent_complete = floor((elapsed_seconds / total_seconds) * 100)
	seconds_remaining = total_seconds - elapsed_seconds
	if percent_complete == 100:
		stop()
		pomodoro.change_state.emit(Pomodoro.States.TIMER_COMPLETE)


func _on_submit_time(time_seconds: float) -> void:
	reset_timer()
	total_seconds = time_seconds
	seconds_remaining = time_seconds
	start()
