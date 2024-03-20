extends Button

@onready var time_box_hours: TimeBox = %TimeBoxHours
@onready var time_box_mins: TimeBox = %TimeBoxMins
@onready var time_box_secs: TimeBox = %TimeBoxSecs


func _on_pressed() -> void:
	time_box_hours.text = ""
	time_box_mins.text = ""
	time_box_secs.text = ""
