extends RefCounted
class_name Animal

# Atributos básicos individuales
var id: String
var tipo: String          # "Gallina", "Vaca", "Cerdo", "Chivo"
var edad_meses: float = 1.0
var peso_kg: float

# Configuración estándar por especie: [Peso Mínimo, Peso Máximo, Edad Máxima, Factor de Consumo]
# El factor de consumo es el % de su peso corporal que comen al día
var CONFIG_ESPECIE = {
	"Gallina": {"peso_min": 0.5, "peso_max": 3.5, "edad_max": 24, "factor_alimento": 0.05},
	"Vaca":    {"peso_min": 45.0, "peso_max": 600.0, "edad_max": 120, "factor_alimento": 0.03},
	"Cerdo":   {"peso_min": 1.5, "peso_max": 180.0, "edad_max": 36, "factor_alimento": 0.04},
	"Chivo":   {"peso_min": 3.0, "peso_max": 60.0, "edad_max": 48, "factor_alimento": 0.035}
}

# Constructor: Se ejecuta al crear un animal (Animal.new)
func _init(p_tipo: String, p_edad: float, p_peso: float):
	self.id = str(ResourceUID.create_id()) # Genera un identificador único único en el juego
	self.tipo = p_tipo
	self.edad_meses = p_edad
	self.peso_kg = p_peso

# Simulación de crecimiento (Se ejecuta al pasar un día)
func envejecer_y_crecer():
	var config = CONFIG_ESPECIE[tipo]
	
	if edad_meses < config["edad_max"]:
		edad_meses += 1.0 # Avanza su edad
		
		# Crece un 5% de su peso actual en cada ciclo hasta el tope de su especie
		if peso_kg < config["peso_max"]:
			peso_kg = min(peso_kg * 1.05, config["peso_max"])

# Devuelve cuánto come este animal en específico hoy basado en su peso actual
func obtener_consumo_diario() -> float:
	var config = CONFIG_ESPECIE[tipo]
	return peso_kg * config["factor_alimento"]
	
