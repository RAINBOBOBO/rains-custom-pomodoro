extends PomodoroState

var settings_section: VBoxContainer


func enter() -> void:
	settings_section.visible = true


func inject_dependencies(
	settings_complete_signal: Signal,
	p_settings_section: VBoxContainer,
) -> void:
	settings_complete_signal.connect(_on_settings_complete)
	settings_section = p_settings_section


func _on_settings_complete() -> void:
	is_complete = true
