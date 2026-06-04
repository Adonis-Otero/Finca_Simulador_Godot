extends Node2D

# =====================================================================
#                 CONTROLADOR DE INTERFAZ GRÁFICA (UI)
#   Nota para mi compañero: Aquí se conectan los elementos visuales
# =====================================================================

func _ready():
	print("Interfaz gráfica inicializada. Esperando interacciones del usuario...")
	
	# INTENTO DE CARGA: Si hay una partida guardada, la monta. Si no, crea datos iniciales de prueba.
	var partida_encontrada = FincaManager.cargar_partida()
	
	if not partida_encontrada:
		print("Creando datos iniciales de prueba para el primer guardado...")
		FincaManager.comprar_animal("Bovino", 8.0, 280.0, 1800.0)
		FincaManager.avanzar_dia_finca()
		# Guardamos automáticamente para la próxima vez que abras el juego
		FincaManager.guardar_partida()
		
	actualizar_pantalla_datos_globales()


# --- 1. ACTUALIZACIÓN DE TEXTOS EN PANTALLA ---
# Funciones para que tu compañero actualice las etiquetas (Labels) de la UI
func actualizar_pantalla_datos_globales():
	print("\n=== ACTUALIZANDO PANEL GLOBAL ===")
	print("Dinero en pantalla: $", FincaManager.dinero)
	print("Días transcurridos: ", FincaManager.dias_transcurridos)
	print("Bodega Bovinos: ", FincaManager.bodega_alimento["Bovino"], " kg")
	print("Bodega Ovinos: ", FincaManager.bodega_alimento["Ovino"], " kg")
	print("Bodega Porcinos: ", FincaManager.bodega_alimento["Porcinos"], " kg")
	# Nota técnica: Tu compañero usará algo como: $LabelDinero.text = str(FincaManager.dinero)


# --- 2. ACCIONES DE LOS BOTONES DE COMPRA ---
# Tu compañero creará botones y, mediante señales (Signals), los conectará aquí

func _on_boton_comprar_bovino_pressed(edad_ingresada: float, peso_ingresado: float, costo_mercado: float):
	print("\n[UI] Clic en: Comprar Bovino")
	var exito = FincaManager.comprar_animal("Bovino", edad_ingresada, peso_ingresado, costo_mercado)
	if exito:
		actualizar_pantalla_datos_globales()

func _on_boton_comprar_ovino_pressed(edad_ingresada: float, peso_ingresado: float, costo_mercado: float):
	print("\n[UI] Clic en: Comprar Ovino")
	var exito = FincaManager.comprar_animal("Ovino", edad_ingresada, peso_ingresado, costo_mercado)
	if exito:
		actualizar_pantalla_datos_globales()

func _on_boton_comprar_porcino_pressed(edad_ingresada: float, peso_ingresado: float, costo_mercado: float):
	print("\n[UI] Clic en: Comprar Porcino")
	var exito = FincaManager.comprar_animal("Porcinos", edad_ingresada, peso_ingresado, costo_mercado)
	if exito:
		actualizar_pantalla_datos_globales()


# --- 3. ACCIONES DE LOS BOTONES DE TIENDA DE ALIMENTO ---

func _on_boton_comprar_alimento_pressed(tipo_alimento: String, cantidad_kilos: float):
	print("\n[UI] Clic en: Comprar Alimento para ", tipo_alimento)
	# tipo_alimento debe ser estrictamente: "Bovino", "Ovino" o "Porcinos"
	var exito = FincaManager.comprar_alimento(tipo_alimento, cantidad_kilos)
	if exito:
		actualizar_pantalla_datos_globales()


# --- 4. ACCIONES DEL SISTEMA DE TIEMPO ---

func _on_boton_avanzar_dia_pressed():
	print("\n[UI] Clic en: Pasar al siguiente día")
	FincaManager.avanzar_dia_finca()
	actualizar_pantalla_datos_globales()


# --- 5. ACCIONES DEL PANEL DE VENTAS ---

func _on_boton_vender_animal_pressed(id_del_animal_seleccionado: String, precio_pautado: float):
	print("\n[UI] Clic en: Vender Animal ID: ", id_del_animal_seleccionado)
	var exito = FincaManager.vender_animal(id_del_animal_seleccionado, precio_pautado)
	if exito:
		actualizar_pantalla_datos_globales()


# --- 6. ACCIONES DEL MENÚ DE SISTEMA (GUARDAR / CARGAR) ---

func _on_boton_guardar_partida_pressed():
	print("\n[UI] Clic en: Guardar Partida")
	FincaManager.guardar_partida()

func _on_boton_cargar_partida_pressed():
	print("\n[UI] Clic en: Cargar Partida")
	var exito = FincaManager.cargar_partida()
	if exito:
		actualizar_pantalla_datos_globales()
		
		
