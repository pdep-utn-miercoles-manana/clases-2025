class JefeDeDepartamento {

    const subordinados = #{}
    
    method atenderA(alguien) {
        self.algunSubordinado().atenderA(alguien)
    }

    method algunSubordinado() {
        return subordinados.anyOne()
    }

}