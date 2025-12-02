import soliamMurr.*

class Asentamiento {

    var prosperidad

    method pasearPorLaPlaza(_exiliado) {
        self.aumentarProsperidad(5)
    }

    method aumentarProsperidad(cantidad) {
        prosperidad += cantidad
    }

    method irATomarElTe(exiliado) {
        exiliado.irATomarElTe(self)
    }

    method trabajar(cantidadDeHoras, exiliado) {
        const prosperidadPorHora = 50
        self.aumentarProsperidad(cantidadDeHoras * prosperidadPorHora)
        exiliado.trabajar(self)
    }

    method serVisitado(triunvirato) {
        triunvirato.visitarAsentamiento(self)
    }

    method visitarTodasLasPlazas(exiliado) {
        self.cantidadDePlazas().times{_ => self.pasearPorLaPlaza(exiliado)}
    }

    method cantidadDePlazas()

    method tienePlaza() {
        return self.cantidadDePlazas() > 0
    }

}

class Pueblo inherits Asentamiento {

    method visitarMonumento(_exiliado, _monumento) {
        // No hace nada
    }

    method tieneMonumentoASoliamMurr() {
        return false
    }

    override method cantidadDePlazas() = 1

}

class Ciudad inherits Asentamiento {

    var cantidadHabitantes
    const monumentos = []
    const atracciones = []

    method visitarMonumento(exiliado, monumento) {
        exiliado.visitarMonimento(self, monumento)
    }

    method tieneMonumentoASoliamMurr() {
        return monumentos.any{monumento => soliamMurr.esReferenciadoPor(monumento)}
    }

    method visitarMonumentoASoliamMurr(exiliado) {
        exiliado.visitarMonumento(self, self.monumentoASoliamMurr())
    }

    method monumentoASoliamMurr() {
        return monumentos.find{monumento => soliamMurr.esReferenciadoPor(monumento)}
    }

    override method cantidadDePlazas() {
        return self.cantidadDePlazasComoAtracciones() + cantidadHabitantes.div(10000)
    }

    method cantidadDePlazasComoAtracciones() {
        return self.plazasComoAtracciones().size()
    }

    method plazasComoAtracciones() {
        return atracciones.filter{atraccion => atraccion.contains("plaza")}
    }

    method incrementarHabitantes() {
        cantidadHabitantes += 1
    }

}