extends CharacterBody2D

@export var stats : PlayerStatisticsResource # asetetaan tiedosto mistä saadaan data
# asetetaan pelaajan tilastot edellisen tiedoston avulla
@onready var speed = stats.speed
@onready var attack_damage = stats.attack_damage 
@onready var health = stats.health
@onready var defense = stats.defense

# asetetaan pelaajan liikearvot
var dash_speed : int = 2
var is_dashing = false

@onready var dash_timer = $DashTimer as Timer # tehdään muuttuja meidän dash-ajastimesta ja annetaan sille tieto että se on ajastin

@onready var attack_scene : PackedScene = preload("res://scenes/area_attack.tscn") as PackedScene # asetetaan hyökkäys muuttujaksi jota voidaan hyödyntää myöhemmin

var crit_chance : float = 0.05 # asetetaan muuttuja joka määrittää kuinka usein saamme kriittisiä osumia
signal died # signaali sille kun kuolee

func _ready() -> void:
	$ProgressBar.max_value = health # asetetaan elämämittarin maksimiarvoksi elämäpisteiden aloitusarvo
	$CPUParticles2D.emitting = false # varmistetaan ettei pelaajasta lähde partikkeleja

func _physics_process(delta: float) -> void: # 60 kertaa sekunnissa päivittyvä funktio
	get_input(delta) # tarkastetaan mitä nappeja pelaaja painaa
	move_and_slide()
	


func take_damage(amount : int, source_position : Vector2 = Vector2.ZERO):
## Tämä funktio muuttaa pelaajan elämäpisteiden määrän ja pyörittää animaation
	$AnimationPlayer.play("take_dmg") # pyöritetään animaatio
	$CPUParticles2D.emitting = true # asetetaan partikkelit päälle
	health -= amount/(defense) # vähennetään elämäpisteistä vahinko jaettuna puolustuksella
	$ProgressBar.value = health # päivitetään elämämittarin arvo
	await $AnimationPlayer.animation_finished # odotetaan että animaatio loppuu
	if source_position != null or source_position != Vector2.ZERO: # jos vahingon lähde löytyy, eikä se ole pelaajan kanssa samassa pisteessä
		velocity = (position-source_position).normalized()*speed
	#move_and_slide()
	$CPUParticles2D.emitting = false # lopetetaan partikkelien synnyttäminen
	if health <=0: # jos elämäpisteet on nolla tai alle
		die() # kutsutaan funktio die()


func get_input(_delta):
	var move_direction = Input.get_vector("left","right","up","down")
	var attack_direction = get_local_mouse_position().normalized()
	
	if Input.is_action_just_pressed("dash"):
		dash()
	if is_dashing: 
		velocity = attack_direction*speed*dash_speed
	else: velocity = move_direction*speed
	if Input.is_action_just_pressed("attack"):
		area_attack(attack_damage, attack_direction)
	if Input.is_action_just_pressed("game_over"):
		die()

func dash():
	dash_timer.start()
	is_dashing = true

func area_attack(damage : int, dir: Vector2):
	var attack = attack_scene.instantiate()
	attack.look_at(dir)
	if randf() > 1.0-crit_chance:
		attack.damage=damage*2
		print("CRITICAL DAMAGE")
	else: attack.damage = damage
	attack.position = Vector2.ZERO+dir*20
	attack.collision_mask = 4
	
	add_child(attack)
	

func _on_dash_timer_timeout() -> void:
	is_dashing = false

	
# tämä funktio määrittää mitä pelaajalle tapahtuu kuollessa
func die():
	$CollisionShape2D.disabled = true # pelaajaan ei voi törmätä
	$DeathTimer.start()
	$Sprite2D.visible = false #pelaaja muuttuu näkymättömäksi
	velocity = Vector2.ZERO # pelaaja ei liiku enää
	$CPUParticles2D.emitting = true # eritetään partikkeleja
	$ProgressBar.visible = false # piilotetaan elämämittari
	await $DeathTimer.timeout
	died.emit() # lähetetään signaali died
	queue_free() # poistetaan pelaaja
	
