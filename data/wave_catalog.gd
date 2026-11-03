extends RefCounted
class_name WaveCatalog

var base_balloons: int = 10
var max_proportion: float = 5.0
var top_wave: int = 30

func get_balloon_count(wave: int) -> int:
	var safe_top_wave := maxi(top_wave, 2)
	var safe_wave := clampi(wave, 1, safe_top_wave)
	var progress := float(safe_wave - 1) / float(safe_top_wave - 1)
	var proportion := lerpf(1.0, max_proportion, progress)
	var result = roundi(base_balloons * proportion) + wave
	print("Ballon Count:",result)
	return result

func get_available_balloons( wave: int,definitions: Dictionary) -> Array[BallonDefinitions]:
	var available: Array[BallonDefinitions] = []
	var min_hp: int
	var max_hp: int
	var first := true
	for value in definitions.values():
		var definition := value as BallonDefinitions
		if definition == null:
			continue
		if first:
			min_hp = definition.hp
			first = false
		else:
			min_hp = mini(min_hp, definition.hp)		
	if first:
		return available
		
	var safe_wave := clampi(wave, 1, maxi(top_wave, 1))
	var waves_per_hp := 2
	var hp_limit := min_hp + floori(
		float(safe_wave - 1) / float(waves_per_hp)
		)
		
	for value in definitions.values():
		var definition := value as BallonDefinitions
		if definition != null and definition.hp <= hp_limit:
			available.append(definition)
	return available

func get_balloons_for_wave(wave: int,definitions: Dictionary) -> Array[BallonDefinitions]:
	var available := get_available_balloons(wave, definitions)
	var balloons: Array[BallonDefinitions] = []

	if available.is_empty():
		return balloons

	var total := get_balloon_count(wave)

	for i in range(total):
		balloons.append(available.pick_random())

	return balloons
