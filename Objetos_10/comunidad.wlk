class Comunidad {

    const asentamientos = []

    method prosperidad() {
        return asentamientos.sum{asentamiento => asentamiento.prosperidad()}
    }

    method asentamientoMasProspero() {
        return asentamientos.max{asentamiento => asentamiento.prosperidad()}
    }

    method serVisitado(triunvirato) {
        self.asentamientoMasProspero().serVisitado(triunvirato)
    }


    // Solo hace falta si se quiere que sea polimórfica con el asentamiento
    method cantidadDePlazas() {
        return asentamientos.sum{asentamiento => asentamiento.cantidadDePlazas()}
    }

}