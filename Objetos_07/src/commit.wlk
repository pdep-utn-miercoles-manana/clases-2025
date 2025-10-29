class Commit {

    const property cambios = []  
    const property descripcion
    const autor

    method afectaA(nombreArchivo) {
        return self.cambios().any { cambio => cambio.afectaA(nombreArchivo) }
    }
    
    method cambiosOpuestos() {
        return cambios.map { cambio => cambio.opuesto() }.reverse()
    }

    method esAutor(usuario) {
        return autor == usuario
    }

}

class Revert inherits Commit {

    const commit

    override method cambios() {
        return commit.cambiosOpuestos()
    }

    override method descripcion() {
        return "revert " + descripcion
    }

}