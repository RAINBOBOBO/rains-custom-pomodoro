class_name TimerDisplay extends VBoxContainer

signal timer_stop_button_pressed

var pomodoro_timer: PomodoroTimer

@onready var pause_button: Button = %PauseButton
@onready var reset_button: Button = %ResetButton
@onready var stop_button: Button = %StopButton
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var time_remaining: Label = %TimeRemaining


func _ready() -> void:
	EventBus.submit_time.connect(_on_submit_time)


func convert_seconds_to_time(total_seconds: float) -> String:
	var int_seconds: int = int(total_seconds)
	var seconds = int_seconds % 60
	var minutes = (int_seconds / 60) % 60
	var hours = (int_seconds / 60) / 60
	return "%02d:%02d:%02d" % [hours, minutes, seconds]


func inject_timer(p_pomodoro_timer: PomodoroTimer) -> void:
	pomodoro_timer = p_pomodoro_timer
	pomodoro_timer.timeout.connect(_on_pomodoro_timeout)


func _on_submit_time(time_seconds: float) -> void:
	texture_progress_bar.value = 0
	time_remaining.text = (
		"Time remaining: "
		+ convert_seconds_to_time(time_seconds)
	)


func _on_pomodoro_timeout() -> void:
	texture_progress_bar.value = pomodoro_timer.percent_complete
	time_remaining.text = (
		"Time remaining: "
		+ convert_seconds_to_time(pomodoro_timer.seconds_remaining)
	)


func _on_pause_button_pressed() -> void:
	pomodoro_timer.paused = not pomodoro_timer.paused
	if pomodoro_timer.paused:
		pause_button.text = "Paused"
	else:
		pause_button.text = "Pause"


func _on_reset_button_pressed() -> void:
	pomodoro_timer.elapsed_seconds = 0
	texture_progress_bar.value = 0
	time_remaining.text = (
		"Time remaining: "
		+ convert_seconds_to_time(pomodoro_timer.total_seconds)
	)
	pomodoro_timer.paused = true
	pause_button.text = "Paused"


func _on_stop_button_pressed() -> void:
	pomodoro_timer.reset_timer()
	timer_stop_button_pressed.emit()
