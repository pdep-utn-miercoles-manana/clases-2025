import persona.Persona

class Medico inherits Persona {

    var dosis
    
    method atenderA(persona) {
        persona.medicarse(dosis)
    }

    override method contraer(enfermedad) {
        super(enfermedad)
        self.atenderA(self)
    }
}