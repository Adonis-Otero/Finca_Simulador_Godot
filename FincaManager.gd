extends Node

# Variables administrativas de la finca
var dinero: float = 10000.0            # Capital inicial en dólares
var inventario_alimento_kg: float = 500.0 # Kilogramos de alimento en bodega

# Listas de control
var lista_animales: Array[Animal] = []   # Animales actualmente vivos en la granja
var historial_compras: Array[Dictionary] = [] # Registro contable de compras
var historial_ventas: Array[Dictionary] = []  # Registro contable de ventas

# --- COMPRA DE ANIMALES ---
func comprar_animal(tipo: String, edad: float, peso: float, costo: float) -> Animal:
	if dinero >= costo:
		dinero -= costo
		var nuevo_animal = Animal.new(tipo, edad, peso)
		lista_animales.append(nuevo_animal)
		
		# Guardar en el historial de compras
		var registro_compra = {
			"id_animal": nuevo_animal.id,
			"tipo": tipo,
			"edad_al_comprar": edad,
			"peso_al_comprar": peso,
			"costo": costo,
			"fecha_registro": Time.get_date_string_from_system()
		}
		historial_compras.append(registro_compra)
		
		print("COMPRA EXITOSA: ", tipo, " añadida. Dinero restante: $", dinero)
		return nuevo_animal
	else:
		print("ERROR: Fondos insuficientes para comprar este animal.")
		return null

# --- VENTA DE ANIMALES ---
func vender_animal(id_animal: String, precio_venta: float) -> bool:
	for i in range(lista_animales.size()):
		if lista_animales[i].id == id_animal:
			var animal_a_vender = lista_animales[i]
			dinero += precio_venta
			
			# Guardar en el historial de ventas
			var registro_venta = {
				"id_animal": animal_a_vender.id,
				"tipo": animal_a_vender.tipo,
				"edad_al_vender": animal_a_vender.edad_meses,
				"peso_al_vender": animal_a_vender.peso_kg,
				"precio_venta": precio_venta,
				"fecha_registro": Time.get_date_string_from_system()
			}
			historial_ventas.append(registro_venta)
			
			# Eliminar del inventario activo de la finca
			lista_animales.remove_at(i)
			print("VENTA EXITOSA: Ganancia de $", precio_venta, ". Dinero total: $", dinero)
			return true
			
	print("ERROR: No se encontró el animal con el ID provisto.")
	return false

# --- CÁLCULOS DE CONSUMO DE ALIMENTO ---
# Devuelve el total de kilos diarios que consume un grupo (ej: "Vaca")
func obtener_consumo_grupal(tipo_buscado: String) -> float:
	var total_kilos: float = 0.0
	for animal in lista_animales:
		if animal.tipo == tipo_buscado:
			total_kilos += animal.obtener_consumo_diario()
	return total_kilos

# Procesa el gasto de comida de toda la finca
func alimentar_finca_diariamente():
	var consumo_total_finca: float = 0.0
	for animal in lista_animales:
		consumo_total_finca += animal.obtener_consumo_diario()
	
	if inventario_alimento_kg >= consumo_total_finca:
		inventario_alimento_kg -= consumo_total_finca
		print("ALIMENTACIÓN: Se consumieron ", consumo_total_finca, " kg. Quedan ", inventario_alimento_kg, " kg en bodega.")
	else:
		print("¡ALERTA!: No hay comida suficiente en bodega para alimentar a los animales hoy.")

# --- CONTROL DEL TIEMPO ---
# Simula el avance de un día completo: los animales comen y luego crecen
func avanzar_dia_finca():
	print("--- Avanzando el día en la finca ---")
	alimentar_finca_diariamente()
	for animal in lista_animales:
		animal.envejecer_y_crecer()
		
