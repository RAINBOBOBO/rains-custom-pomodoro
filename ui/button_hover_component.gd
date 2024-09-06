class_name ButtonHoverComponent extends Node

@export var from_center: bool = true
@export var hover_scale: Vector2 = Vector2(1.2, 1.2)
@export var time: float = 0.1
@export var transition_type: Tween.TransitionType = (
	Tween.TransitionType.TRANS_CUBIC
)

var target: Control
var default_scale: Vector2


func _ready() -> void:
	target = get_parent()

	_connect_signals()
	call_deferred("_setup")


func _add_tween(property: String, value, seconds: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(
		transition_type
	)


func _connect_signals() -> void:
	target.resized.connect(_setup)
	target.mouse_entered.connect(_on_hover)
	target.mouse_exited.connect(_off_hover)


func _on_hover() -> void:
	_add_tween("scale", hover_scale, time)


func _off_hover() -> void:
	_add_tween("scale", default_scale, time)


func _setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2

	default_scale = target.scale
