class Cambio {

    const property nombreArchivo

    method aplicarEn(carpeta) {
        self.validarCambioEn(carpeta)
        self.aplicarPostaEn(carpeta)
    }

    method validarCambioEn(carpeta) {
        if(not carpeta.contieneArchivo(nombreArchivo)) {
            self.error("No existe el archivo " + nombreArchivo + " en la carpeta " + carpeta.nombre())
        }
    }

    method aplicarPostaEn(carpeta)

    method afectaA(unNombreArchivo) {
        return nombreArchivo == unNombreArchivo
    }

    method opuesto()

}

class Crear inherits Cambio {
    
    override method aplicarPostaEn(carpeta) {
        carpeta.crearArchivo(nombreArchivo)
    }

    override method validarCambioEn(carpeta) {
        if(carpeta.contieneArchivo(nombreArchivo)) {
            self.error("Ya existe el archivo " + nombreArchivo + " en la carpeta " + carpeta.nombre())
        }
    }

    override method opuesto() {
        return new Eliminar(nombreArchivo = self.nombreArchivo())
    }

}

class Eliminar inherits Cambio {

    override method aplicarPostaEn(carpeta) {
        carpeta.eliminarArchivo(nombreArchivo)
    }

    override method opuesto() {
        return new Crear(nombreArchivo = self.nombreArchivo())
    }

}

class AgregarContenido inherits Cambio {

    const property contenido

    override method aplicarPostaEn(carpeta) {
        carpeta.agregarContenidoAlArchivo(nombreArchivo, contenido)
    }

    override method opuesto() {
        return new SacarContenido(
            nombreArchivo = self.nombreArchivo(),
            contenido = self.contenido()
        )
    }

}

class SacarContenido inherits Cambio {

    const property contenido

    override method aplicarPostaEn(carpeta) {
        carpeta.sacarContenidoDelArchivo(nombreArchivo, contenido)
    }

    override method opuesto() {
        return new AgregarContenido(
            nombreArchivo = self.nombreArchivo(),
            contenido = self.contenido()
        )
    }

}

