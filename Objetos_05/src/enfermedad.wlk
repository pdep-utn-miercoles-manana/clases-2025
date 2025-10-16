

class EnfermedadInfecciosa inherits Enfermedad {

  override method esAgresivaPara(persona) = persona.celulas() * 0.1 <= celulasAmenazadas

  override method afectar(alguien) { 
    alguien.aumentarTemperatura(celulasAmenazadas / 1000)
  }

  method reproducite() {
    celulasAmenazadas *= 2
  }

}

// Es una enfermedad autoinmune, pero es la única, así que por ahora nos alcanza con modelar esta sola
class EnfermedadAutoinmune inherits Enfermedad {

  var cantidadDeAfecciones = 0

  override method afectar(alguien) {
    alguien.reducirCelulas(10000)
    cantidadDeAfecciones += 1
  }

  override method esAgresivaPara(_persona) = cantidadDeAfecciones > 30

}

class Enfermedad {

  var celulasAmenazadas = 1

  method celulasAmenazadas() = celulasAmenazadas

  method atenuarse(cantidadCelulas) {
    celulasAmenazadas = 0.max(celulasAmenazadas - cantidadCelulas)
  }

  method afectar(alguien)

  method esAgresivaPara(alguien)

  method estaCurada() {
    return celulasAmenazadas == 0
  }

}

const lupus = new EnfermedadInfecciosa()