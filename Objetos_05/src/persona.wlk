import src.exceptions.*
import enfermedad.*
import grupo.grupoA

class Persona {

  const enfermedades = #{}
  var temperatura = 36
  var celulas = 3000000
  const factor = true
  const grupo = grupoA

  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.afectar(self) })
  }

  method aumentarTemperatura(unaCantidad) {
    temperatura = (temperatura + unaCantidad).min(45)
  }

  method reducirCelulas(unaCantidad) {
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

  method donarSangre(receptor, cantidadCelulasADonar) {
    if (!self.puedeHacerTransfusion(receptor, cantidadCelulasADonar)) {
      throw new TransfusionInvalidaException(message = "pará loco, no puede donar!!")
    }
    receptor.aumentarCelulas(cantidadCelulasADonar)
    self.reducirCelulas(cantidadCelulasADonar)
  }

  method puedeHacerTransfusion(receptor, cantidadCelulasADonar) {
    return self.alcanzanCelulas(cantidadCelulasADonar) && self.esCompatibleCon(receptor)
  }

  method alcanzanCelulas(cantidadCelulas) = 
    cantidadCelulas.between(500, celulas * 0.25)

  method esCompatibleCon(receptor) = self.grupoCompatible(receptor) &&
    self.factorCompatible(receptor)

  method grupoCompatible(receptor) = grupo.esCompatibleCon(receptor.grupo())
  method factorCompatible(receptor) = !factor 
    || (factor && receptor.factor())

  method factor() = factor
}
