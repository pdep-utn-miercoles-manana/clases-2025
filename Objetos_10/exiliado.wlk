import soliamMurr.*

class Exiliado {

    const leGustaElTe
    var cantidadDeDiasExiliado = 0
    
    method visitarMonumento(_asentamiento, _monumento) {
        // No hace nada   
    }

    method irATomarElTe(asentamiento) {
        asentamiento.aumentarProsperidad(10 * if(leGustaElTe) 1 else -1)
    }

    method trabajar(cantidadDeHoras, asentamiento) {
        cantidadDeDiasExiliado += 1
    }

}

class Nomada inherits Exiliado {

    override method visitarMonumento(asentamiento, monumento) {
        if(self.esDemonio() and soliamMurr.esReferenciadoPor(monumento)) {
            asentamiento.incrementarHabitantes()
        }
    }

    method congraciarse(exiliado, asentamiento, triunvirato) {

        if(self.esDemonio() and asentamiento.tieneMonumentoASoliamMurr()) {
            asentamiento.visitarMonumentoASoliamMurr(self)
            asentamiento.visitarMonumentoASoliamMurr(exiliado)
        }

        const horasATrabajar = self.horasDeTrabajoCongraciadas()
        exiliado.trabajar(horasATrabajar, asentamiento)
        
        const compañero = triunvirato.compañeroCualquieraDe(self)
        exiliado.descansar(asentamiento)
        compañero.descansar(asentamiento)

    }

    method esDemonio() {
        return cantidadDeDiasExiliado > 1000
    }

    method horasDeTrabajoCongraciadas() {
        return (2..6).anyOne()
    }

    method descansar(asentamiento) {
        if(asentamiento.tienePlaza()) {
            asentamiento.pasearPorLaPlaza(self)
        }
        asentamiento.irATomarElTe(self)
    }

}

class Diablillo inherits Exiliado {
    
    method congraciarse(exiliado, asentamiento, _triunvirato) {
        asentamiento.visitarTodasLasPlazas(exiliado)
    }

}

class Sabueso inherits Exiliado {

    method congraciarse(_exiliado, _asentamiento, _triunvirato) {
        // No hace nada
    }

}