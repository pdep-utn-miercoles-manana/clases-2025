import enfermedad.*

class Persona {

  const enfermedades = #{}
  var temperatura = 36
  var celulas = 3000000

  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.afectar(self) })
  }

  method aumentarTemperatura(unaCantidad) {
    temperatura = (temperatura + unaCantidad).min(45)
  }

  method destruirCelulas(unaCantidad) {
    celulas = (celulas - unaCantidad).max(0)
  }
  method cantidadDeCelulasAmenazadasPorEnfermedadesAgresivas2() {
	return self.enfermedadesAgresivas().sum({ enfermedad => enfermedad.celulasAmenazadas() })
  }

   method enfermedadesAgresivas() {
	return enfermedades.filter({ enfermedad => enfermedad.esAgresivo(self) })
   }

  method enfermedadQueMasCelulasAfecta() = lupus

  method estaEnComa() = temperatura == 45 or celulas < 1000000

  method temperatura() = temperatura

  method celulas() = celulas

  method contraer(enfermedad) {
    enfermedades.add(enfermedad)
  }

  method cantidadEnfermedades() {
	return enfermedades.size()
  }

  method medicarse(dosis) {
	enfermedades.forEach({ enfermedad => enfermedad.atenuarse(15 * dosis) })
	self.eliminarEnfermedadesCuradas()
  }

  method eliminarEnfermedadesCuradas() {
	enfermedades.removeAllSuchThat({ enfermedad => enfermedad.estaCurada() })
  }

}
