extends CharacterBody2D

const SPEED = 500.0

var jump_velocity = -700.0
var was_in_air = false
var player_score=0

@onready var sprite = $Sprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var score_label = get_node("/root/Node/CanvasLayer/Label")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		randomize_sprite_color()
		was_in_air = false
	
	if not is_on_floor() and not is_on_ceiling():
		was_in_air = true
		
	if Input.is_action_just_pressed("flip_gravity"):
		gravity *= -1
		jump_velocity *= -1
		sprite.scale.y *= -1
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_ceiling()):
		velocity.y = jump_velocity

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func randomize_sprite_color():
	sprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)
	player_score=player_score+1
	score_label.text = "Bounces: " + str(player_score)
