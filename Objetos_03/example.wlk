// Logan, con temperatura normal (36 grados) y con 3.000.000 de células, habiendo contraído las tres enfermedades del ítem a).
const logan = new Paciente(enfermedades = #{malaria500, otitis100, lupus}, celulas = 3000000)
// Frank, coperatura normal y 3.500.000 células.n tem
const frank = new Paciente(enfermedades = #{}, celulas = 3500000)

const malaria500 = new EnfermedadInfecciosa(celulasAmenazadas = 500)
const malaria800 = new EnfermedadInfecciosa(celulasAmenazadas = 800)
const otitis100 = new EnfermedadInfecciosa(celulasAmenazadas = 100)

class EnfermedadInfecciosa {
  var celulasAmenazadas

  method celulasAmenazadas() = celulasAmenazadas
  method esAgresivo(persona) = persona.celulas() * 0.1 <= self.celulasAmenazadas()
  method afectar(alguien) { 
    alguien.aumentarTemperatura(celulasAmenazadas / 1000)
  }
  method reproducite() {
    celulasAmenazadas *= 2
  }
}

// es una enfermedad autoinmune, pero es la única, así que por ahora nos alcanza con modelar esta sola
object lupus {
  var cantidadDeAfecciones = 0

  method afectar(alguien) {
    alguien.destruirCelulas(10000)
    cantidadDeAfecciones += 1
  }

  method esAgresivo(_persona) = cantidadDeAfecciones > 30

  method celulasAmenazadas() = 10000
}


class Paciente {
  const enfermedades
  var temperatura = 36
  var celulas

  method vivirUnDia() {
    enfermedades.forEach({ enfermedad => enfermedad.afectar(self) })
  }

  method aumentarTemperatura(unaCantidad) {
    temperatura = (temperatura + unaCantidad).min(45)
  }

  method destruirCelulas(unaCantidad) {
    celulas = (celulas - unaCantidad).max(0)
  }

  method cantidadDeCelulasAmenazadasPorEnfermedadesAgresivas() = enfermedades
    .filter({ enfermedad => enfermedad.esAgresivo(self) })
    .sum({ enfermedad => enfermedad.celulasAmenazadas() })

  method enfermedadQueMasCelulasAfecta() = lupus
  method estaEnComa() = temperatura == 45 or celulas < 1000000

  method temperatura() = temperatura

  method celulas() = celulas

  method contraer(enfermedad) {
    enfermedades.add(enfermedad)
  }
}

// todos los bloques son objetos que entienden el método apply, por lo tanto este objeto
// es polimórfico con los bloques y puedo usarlos en el forEach, map, filter y otros métodos de orden superior sobre listas
object miApply {
  method apply(enfermedad) {
    enfermedad.afectar(logan)
  }
}