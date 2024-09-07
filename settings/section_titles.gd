extends VBoxContainer

@export var selected_panel: Panel
@export var hover_panel: Panel
@export var audio_button: Button
@export var video_button: Button
@export var appearance_button: Button
@export var personalization_button: Button

var panel_offset: int = 300


func hide_panels() -> void:
	selected_panel.visible = false
	hover_panel.visible = false


func move_hover_panel_to_button(button: Button) -> void:
	hover_panel.global_position.y = button.global_position.y - 10
	hover_panel.global_position.x = button.global_position.x + panel_offset
	hover_panel.visible = true


func move_selected_panel_to_button(button: Button) -> void:
	selected_panel.global_position.y = button.global_position.y - 10


func toggle_button(button: Button) -> void:
	untoggle_all()
	button.set_pressed_no_signal(true)
	move_selected_panel_to_button(button)


func untoggle_all() -> void:
	audio_button.set_pressed_no_signal(false)
	video_button.set_pressed_no_signal(false)
	appearance_button.set_pressed_no_signal(false)
	personalization_button.set_pressed_no_signal(false)


func _on_audio_section_mouse_entered() -> void:
	move_hover_panel_to_button(audio_button)


func _on_audio_section_mouse_exited() -> void:
	hover_panel.visible = false


func _on_video_section_mouse_entered() -> void:
	move_hover_panel_to_button(video_button)


func _on_video_section_mouse_exited() -> void:
	hover_panel.visible = false


func _on_appearance_section_mouse_entered() -> void:
	move_hover_panel_to_button(appearance_button)


func _on_appearance_section_mouse_exited() -> void:
	hover_panel.visible = false


func _on_personalization_section_mouse_entered() -> void:
	move_hover_panel_to_button(personalization_button)


func _on_personalization_section_mouse_exited() -> void:
	hover_panel.visible = false
