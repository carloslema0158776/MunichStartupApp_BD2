package com.munichstartup

data class Proyecto(
    val idProyecto: Int,
    val nombreProyecto: String,
    val metaFinanciamiento: Double,
    var montoRecaudado: Double,
    var estado: String
)

data class Inversion(
    val idInversionista: Int,
    val idProyecto: Int,
    val monto: Double
)

fun main() {
    println("=== Munich Startup App - Backend BD II ===")
    
    val proyecto = Proyecto(1, "EcoTech Solutions", 50000.0, 15000.0, "ACTIVO")
    println("Proyecto inicial: proyecto")

    val nuevaInversion = Inversion(idInversionista = 2, idProyecto = 1, monto = 10000.0)
    println("Registrando inversión de: {nuevaInversion.monto} USD")

    proyecto.montoRecaudado += nuevaInversion.monto
    if (proyecto.montoRecaudado >= proyecto.metaFinanciamiento) {
        proyecto.estado = "COMPLETADO"
    }

    println("Proyecto actualizado: proyecto")
}
