extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_killzone_body_entered(_body: Node2D) -> void:
	print("Player Dead- Resetting")
	get_tree().call_deferred("reload_current_scene")
