import medico.Medico

class JefeDeDepartamento inherits Medico {

    const subordinados = #{}
    
    override method atenderA(alguien) {
        self.algunSubordinado().atenderA(alguien)
    }

    method algunSubordinado() {
        return subordinados.anyOne()
    }

}