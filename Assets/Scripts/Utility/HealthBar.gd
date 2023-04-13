extends Control
onready var healthBar = $HealthBar

func UpdateHealth(health):
	healthBar.value = health

func UpdateMaxHealth(health):
	healthBar.max_value = health
