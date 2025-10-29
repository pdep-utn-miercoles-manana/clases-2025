import archivo.*

class Carpeta {

    const archivos = #{}

    method contieneArchivo(nombreArchivo) {
        return archivos.any { archivo => archivo.seLlama(nombreArchivo) }
    }

    method commitear(cambios) {
        cambios.forEach { cambio => cambio.aplicarEn(self) }
    }

    method crearArchivo(nombreArchivo) {
        archivos.add(new Archivo(nombre = nombreArchivo))
    }

    method eliminarArchivo(nombreArchivo) {
        archivos.removeAllSuchThat { archivo => archivo.seLlama(nombreArchivo) }
    }

    method agregarContenidoAlArchivo(nombreArchivo, contenido) {
        self.archivoConNombre(nombreArchivo).agregarContenido(contenido)
        // TODO: evitar repetición de lógica con sacarContenidoDelArchivo
    }

    method archivoConNombre(nombreArchivo) {
        return archivos.find { archivo => archivo.seLlama(nombreArchivo) }
    }

    method sacarContenidoDelArchivo(nombreArchivo, contenido) {
        self.archivoConNombre(nombreArchivo).sacarContenido(contenido)
    }

}