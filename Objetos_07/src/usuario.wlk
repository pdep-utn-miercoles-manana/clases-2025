import branch.*

class Usuario {

    var esAdmin = false 

    method branch(unosColaboradores) {
        return new Branch(colaboradores = unosColaboradores)
    }

    method commitear(branch, commit) {
        branch.validarPermisos(self)
        self.validarAutor(commit)
        branch.commitear(commit)
    }

    method esAdmin() {
        return esAdmin
    }

    method validarAutor(commit) {
        if(not commit.esAutor(self)) {
            self.error("El usuario no es autor del commit")
        }
    }

}