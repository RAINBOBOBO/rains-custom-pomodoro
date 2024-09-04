extends PomodoroState

var settings_signal: Signal
var start_timer_signal: Signal
var input_section: VBoxContainer


func enter() -> void:
	input_section.visible = true


func inject_dependencies(
	p_settings_signal: Signal,
	p_start_timer_signal: Signal,
	p_input_section: VBoxContainer,
) -> void:
	settings_signal = p_settings_signal
	settings_signal.connect(_on_settings_signal)
	start_timer_signal = p_start_timer_signal
	start_timer_signal.connect(_on_start_timer_signal)
	input_section = p_input_section


func _on_settings_signal() -> void:
	_select_next_state(state_manager.settings)


func _on_start_timer_signal() -> void:
	_select_next_state(state_manager.work)
