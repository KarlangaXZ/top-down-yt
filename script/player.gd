class_name Player extends CharacterBody2D

@onready var sprite_animation: AnimatedSprite2D = $AnimatedSprite2D

var move_speed := 100
var attact_damage := 50
var is_attack := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed == true:
				attack()

func _physics_process(delta: float) -> void:
	if is_attack == false:
		var move_direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		
		if move_direction:
			velocity = move_direction * move_speed
		
		move_and_slide()

func attack():
	sprite_animation.play("attack")
	is_attack = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_animation.animation == "attack":
		is_attack = false
