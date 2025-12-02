class Triunvirato {

    const property miembros = []
    var lider

    method estaActivo() {
        return self.cantidadDeMiembros() >= 3
    }

    method cantidadDeMiembros() {
        return miembros.size()
    }

    method agregarMiembro(miembro) {
        miembros.add(miembro)
    }

    method lider(nuevoLider) {
        self.validarCambioDeLider(nuevoLider)
        lider = nuevoLider
    }

    method validarCambioDeLider(nuevoLider) {
        if(not miembros.contains(nuevoLider)) {
            self.error("El nuevo líder no pertenece al triunvirato")
        }
    }

    method visitarAsentamiento(asentamiento) {
        miembros.forEach{miembro => lider.congraciarse(miembro, asentamiento, miembros)}
    }

    method compañeroCualquieraDe(exiliado) {
        return self.miembrosSin(exiliado).anyOne()
    }

    method miembrosSin(exiliado) {
        return miembros.filter{miembro => miembro != exiliado}
    }
    
}