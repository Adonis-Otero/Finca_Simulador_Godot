extends Node2D

func _ready():
	print("==================================================")
	print("   INICIANDO SIMULACIÓN DE PRUEBA DE LA FINCA     ")
	print("==================================================")
	
	# 1. Estado Inicial
	print("Estado inicial -> Dinero: $", FincaManager.dinero, " | Alimento: ", FincaManager.inventario_alimento_kg, " kg")
	
	print("\n--- PASO 1: COMPRANDO ANIMALES ---")
	# Compramos una vaca joven (45kg) por $1200 y una gallina (0.5kg) por $10
	FincaManager.comprar_animal("Vaca", 2.0, 50.0, 1200.0)
	FincaManager.comprar_animal("Gallina", 1.0, 0.6, 10.0)
	
	# Verificamos cuántos animales hay en total
	print("Animales totales en la finca: ", FincaManager.lista_animales.size())
	
	print("\n--- PASO 2: REVISANDO CONSUMO DIARIO INDIVIDUAL ---")
	for animal in FincaManager.lista_animales:
		print("- Un/a ", animal.tipo, " de ", animal.peso_kg, " kg consume: ", animal.obtener_consumo_diario(), " kg/día")

	print("\n--- PASO 3: SIMULANDO EL PASO DEL TIEMPO (AVANZAR DÍA) ---")
	# Hacemos avanzar el día. Esto restará comida y hará crecer a los animales
	FincaManager.avanzar_dia_finca()
	
	print("\n--- PASO 4: REVISANDO CRECIMIENTO TRAS AVANZAR EL DÍA ---")
	for animal in FincaManager.lista_animales:
		print("- El/La ", animal.tipo, " ahora pesa: ", animal.peso_kg, " kg y tiene ", animal.edad_meses, " meses de edad.")

	print("\n--- PASO 5: VENDIENDO UN ANIMAL ---")
	# Tomamos el primer animal de la lista (la vaca) y lo vendemos por $1500
	var animal_a_vender = FincaManager.lista_animales[0]
	FincaManager.vender_animal(animal_a_vender.id, 1500.0)
	
	print("\n--- PASO 6: REVISANDO HISTORIALES CONTABLES ---")
	print("Historial de Compras registrado (Total): ", FincaManager.historial_compras.size(), " operaciones.")
	print("Historial de Ventas registrado (Total): ", FincaManager.historial_ventas.size(), " operaciones.")
	
	print("\n==================================================")
	print("             FIN DE LA SIMULACIÓN                 ")
	print("==================================================")
	
	
