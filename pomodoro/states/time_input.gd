extends PomodoroState

var start_timer_signal: Signal
var input_section: VBoxContainer


func enter() -> void:
	input_section.visible = true


func inject_dependencies(
	p_start_timer_signal: Signal,
	p_input_section: VBoxContainer,
) -> void:
	start_timer_signal = p_start_timer_signal
	start_timer_signal.connect(_on_start_timer_signal)
	input_section = p_input_section


func _on_start_timer_signal() -> void:
	is_complete = true
