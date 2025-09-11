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
			sprite_animation.play("run")
			if move_direction.x != 0:
				sprite_animation.flip_h = move_direction.x < 0
		
		else:
			velocity = velocity.move_toward(Vector2.ZERO, move_speed)
			sprite_animation.play("idle")
		
		move_and_slide()

func attack():
	sprite_animation.play("attack")
	is_attack = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_animation.animation == "attack":
		is_attack = false

#Cuando el enemigo este en la zona de ataque.
func _on_area_attack_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

#Cuando el enemigo este FUERA de la zona de ataque.
func _on_area_attack_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
