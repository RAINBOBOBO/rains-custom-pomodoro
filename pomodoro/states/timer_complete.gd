extends PomodoroState

var finished_button_pressed: Signal
var finished_section: VBoxContainer


func enter() -> void:
	finished_section.visible = true


func inject_dependencies(
	p_finished_button_pressed: Signal,
	p_finished_section: VBoxContainer,
) -> void:
	finished_button_pressed = p_finished_button_pressed
	finished_button_pressed.connect(_on_finished_button_pressed)
	finished_section = p_finished_section


func _on_finished_button_pressed() -> void:
	is_complete = true
