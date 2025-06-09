extends CharacterBody2D

class_name Player
const GRAVITY: float = 600.0
const RUN_SPEED: float = 150
const JUMP_SPEED: float = -270.0
const MAX_FALL: float = 350.0

@onready var player_cam: Camera2D = $PlayerCam
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var fell_off_y: float = 100.0
@export var lives: int = 5
@export var camera_min: Vector2 = Vector2(-10000, 10000)
@export var camera_max: Vector2 = Vector2(10000, -10000)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player _ready")
	set_camera_limits()
	
func set_camera_limits() -> void:
	player_cam.limit_bottom = camera_min.y
	player_cam.limit_left = camera_min.x
	player_cam.limit_top = camera_max.y
	player_cam.limit_right = camera_max.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	get_input()
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	move_and_slide()
	
func get_input() -> void:
	
	#if _is_hurt == true:
	#	return
	
	if is_on_floor() and Input.is_action_just_pressed("jump") == true:
		velocity.y = JUMP_SPEED
	#	play_effect(JUMP)
		
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if is_equal_approx(velocity.x, 0.0) == false:
		sprite_2d.flip_h = velocity.x < 0
