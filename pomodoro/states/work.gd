class_name PomodoroWorkState extends PomodoroState

var stop_timer_signal: Signal
var timer_display_section: VBoxContainer


func enter() -> void:
	timer_display_section.visible = true


func inject_dependencies(
	p_stop_timer_signal: Signal,
	p_timer_display_section: VBoxContainer,
) -> void:
	stop_timer_signal = p_stop_timer_signal
	stop_timer_signal.connect(_on_stop_timer_signal)
	timer_display_section = p_timer_display_section


func _on_stop_timer_signal() -> void:
	is_complete = true
