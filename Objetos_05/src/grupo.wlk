/*
Una alternativa es tener una clase Grupo y que sepa con quiénes es compatible

class Grupo {
    const nombre
    const gruposCompatibles

    method esCompatibleCon(otroGrupo) = (#{nombre} + gruposCompatibles).contains(otroGrupo.nombre())

    method nombre() = nombre
}
*/

object grupoA {
    method esCompatibleCon(otroGrupo) =
        #{self, grupoAB}.contains(otroGrupo)
}

object grupoB {
    method esCompatibleCon(otroGrupo) =
        #{self, grupoAB}.contains(otroGrupo)
}

object grupoAB {
    method esCompatibleCon(otroGrupo) =
        #{self}.contains(otroGrupo)
}

object grupo0 {
    method esCompatibleCon(otroGrupo) =
        #{self, grupoA, grupoAB, grupoB}.contains(otroGrupo)
}

object grupoR {
    method esCompatibleCon(otroGrupo) = otroGrupo == self
}