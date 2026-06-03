extends RefCounted
class_name Animal

var id: String
var tipo: String          # "Bovino", "Ovino", "Porcino"
var edad_meses: float = 1.0
var peso_kg: float
var salud: float = 100.0  

# Configuración técnica adaptada a los tres grupos
# [Peso Mínimo, Peso Máximo, Edad Máxima (meses), Factor de Consumo diario]
var CONFIG_ESPECIE = {
	"Bovino":  {"peso_min": 45.0, "peso_max": 650.0, "edad_max": 144, "factor_alimento": 0.03},  # Pasto/Forraje
	"Ovino":   {"peso_min": 4.0,  "peso_max": 80.0,  "edad_max": 96,  "factor_alimento": 0.035}, # Forraje picado
	"Porcinos": {"peso_min": 1.5,  "peso_max": 220.0, "edad_max": 48,  "factor_alimento": 0.04}   # Alimento concentrado
}

func _init(p_tipo: String, p_edad: float, p_peso: float):
	self.id = str(ResourceUID.create_id()) 
	self.tipo = p_tipo
	self.edad_meses = p_edad
	self.peso_kg = p_peso

func envejecer_y_crecer():
	var config = CONFIG_ESPECIE[tipo]
	if edad_meses < config["edad_max"]:
		edad_meses += 1.0 
		if peso_kg < config["peso_max"] and salud > 50:
			# Crecimiento mensual simulado
			peso_kg = min(peso_kg * 1.05, config["peso_max"])

func obtener_consumo_diario() -> float:
	var config = CONFIG_ESPECIE[tipo]
	return peso_kg * config["factor_alimento"]

func afectar_por_hambre():
	salud = max(salud - 25, 0)
	peso_kg = peso_kg * 0.98  # Pérdida de peso por desnutrición
	print("  -> ¡Alerta! ", tipo, " (ID: ", id, ") presenta desnutrición. Salud: ", salud, "%, Peso: ", peso_kg, " kg.")
