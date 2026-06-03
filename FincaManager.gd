extends Node

var dinero: float = 10000.0            
var dias_transcurridos: int = 0         

# Bodega con los tres alimentos específicos
var bodega_alimento = {
	"Bovino":  500.0,  # kg de Silo/Pasto concentrado
	"Ovino":   200.0,  # kg de Forraje específico
	"Porcinos": 300.0   # kg de Alimento concentrado porcino
}

# Precios por kilogramo en el mercado de suministros
var PRECIOS_ALIMENTO = {
	"Bovino":  2.5,
	"Ovino":   1.8,
	"Porcinos": 2.0
}

var lista_animales: Array[Animal] = []   
var historial_compras: Array[Dictionary] = [] 
var historial_ventas: Array[Dictionary] = []  

# --- COMPRA DE ANIMALES ---
func comprar_animal(tipo: String, edad: float, peso: float, costo: float) -> Animal:
	if not bodega_alimento.has(tipo):
		print("ERROR: Tipo de animal no válido para esta finca.")
		return null
		
	if dinero >= costo:
		dinero -= costo
		var nuevo_animal = Animal.new(tipo, edad, peso)
		lista_animales.append(nuevo_animal)
		
		var registro_compra = {
			"id_animal": nuevo_animal.id,
			"tipo": tipo,
			"edad_al_comprar": edad,
			"peso_al_comprar": peso,
			"costo": costo,
			"fecha_registro": "Día " + str(dias_transcurridos)
		}
		historial_compras.append(registro_compra)
		print("COMPRA: ", tipo, " registrado con éxito.")
		return nuevo_animal
	else:
		print("ERROR: Capital insuficiente.")
		return null

# --- VENTA DE ANIMALES ---
func vender_animal(id_animal: String, precio_base: float) -> bool:
	for i in range(lista_animales.size()):
		if lista_animales[i].id == id_animal:
			var animal_a_vender = lista_animales[i]
			
			# Castigo al precio si el animal no está al 100% de salud
			var precio_final = precio_base * (animal_a_vender.salud / 100.0)
			dinero += precio_final
			
			var registro_venta = {
				"id_animal": animal_a_vender.id,
				"tipo": animal_a_vender.tipo,
				"edad_al_vender": animal_a_vender.edad_meses,
				"peso_al_vender": animal_a_vender.peso_kg,
				"precio_venta": precio_final,
				"fecha_registro": "Día " + str(dias_transcurridos)
			}
			historial_ventas.append(registro_venta)
			
			lista_animales.remove_at(i)
			print("VENTA: ", animal_a_vender.tipo, " vendido por $", precio_final)
			return true
	return false

# --- COMPRA DE ALIMENTO ---
func comprar_alimento(tipo_animal: String, cantidad_kg: float) -> bool:
	if not bodega_alimento.has(tipo_animal):
		return false
		
	var costo_total = cantidad_kg * PRECIOS_ALIMENTO[tipo_animal]
	if dinero >= costo_total:
		dinero -= costo_total
		bodega_alimento[tipo_animal] += cantidad_kg
		print("MERCADO: Comprados ", cantidad_kg, " kg para el grupo ", tipo_animal)
		return true
	return false

# --- SISTEMA DE ALIMENTACIÓN POR GRUPO ---
func alimentar_finca_diariamente():
	var necesidades_del_dia = {"Bovino": 0.0, "Ovino": 0.0, "Porcinos": 0.0}
	
	for animal in lista_animales:
		necesidades_del_dia[animal.tipo] += animal.obtener_consumo_diario()
	
	for tipo in necesidades_del_dia.keys():
		var requerido = necesidades_del_dia[tipo]
		if requerido == 0: continue
		
		if bodega_alimento[tipo] >= requerido:
			bodega_alimento[tipo] -= requerido
			actualizar_salud_grupo(tipo, true)
		else:
			bodega_alimento[tipo] = 0.0
			actualizar_salud_grupo(tipo, false)

func actualizar_salud_grupo(tipo_animal: String, alimentado: bool):
	for animal in lista_animales:
		if animal.tipo == tipo_animal:
			if alimentado:
				animal.salud = min(animal.salud + 10, 100)
			else:
				animal.afectar_por_hambre()

# --- CONTROL DEL TIEMPO ---
func avanzar_dia_finca():
	dias_transcurridos += 1
	print("\n--- PROCESANDO DÍA ", dias_transcurridos, " ---")
	alimentar_finca_diariamente()
	for animal in lista_animales:
		animal.envejecer_y_crecer()
