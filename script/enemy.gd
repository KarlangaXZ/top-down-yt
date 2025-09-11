class_name Enemy extends CharacterBody2D

var move_speed := 50
var attack_damage := 10
var is_attack := false
var attack_player_range := false

@onready var player: Player = $"../Player"
@onready var sprite_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_components: HealthComponent = $Components/HealthComponents

func _ready() -> void:
	if player:
		player.attack_finished.connect(verify_receive_damage)
	
	health_components.death.connect(on_death)

func _physics_process(delta: float) -> void:
	if !is_attack and player:
		sprite_animation.play("run")
		
		var move_direction = (player.position - position).normalized()
		if move_direction:
			velocity = move_direction * move_speed
			if move_direction.x != 0:
				sprite_animation.flip_h = move_direction.x < 0
				$AreaAttack.scale.x = -1 if move_direction.x < 0 else 1
			
		move_and_slide()

func attack():
	sprite_animation.play("attack")
	is_attack = true

func verify_receive_damage():
	if attack_player_range == true :
		health_components.receive_damage(player.attact_damage)

func on_death():
	queue_free()

#Cuando el player entre a la zona de ataque del enemigo.
func _on_area_attack_body_entered(body: Node2D) -> void:
	if body is Player:
		attack()

#Cuando el player salga del rango de ataque del enemigo
func _on_area_attack_body_exited(body: Node2D) -> void:
	if body is Player:
		is_attack = false

#Cuando la animacion del ataque termine
func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite_animation.animation == "attack":
		player.health_components.receive_damage(attack_damage)
		if is_attack:
			attack()
