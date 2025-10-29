class Branch {

    const commits = []
    const colaboradores = []
    
    method checkoutEn(carpeta) {
        commits.forEach { commit => carpeta.commitear(commit) }
    }

    method log(nombreArchivo) {
        return commits.filter { commit => commit.afectaA(nombreArchivo) }
    }

    method commitear(commit) {
        commits.add(commit)
    }
    
    method validarPermisos(usuario) {
        if(self.tienePermisos(usuario)) {
            self.error("El usuario no tiene permisos sobre la branch.")
        }
    }

    method tienePermisos(usuario) {
        return not self.esColaborador(usuario) or not usuario.esAdmin()
    }

    method esColaborador(usuario) {
        return colaboradores.contains(usuario)
    }

    method blame(nombreArchivo) {
        return self.log(nombreArchivo).map { commit => commit.autor() }
    }

}