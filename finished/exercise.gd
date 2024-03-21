class_name exercise extends Label

var current_phrase: Exercise_Phrase

@export var phrases: ResourceGroup
var _phrases: Array[Exercise_Phrase] = []


func _ready() -> void:
	phrases.load_all_into(_phrases)


func _on_visibility_changed() -> void:
	if visible:
		current_phrase = _phrases.pick_random()
		text = current_phrase.phrase
