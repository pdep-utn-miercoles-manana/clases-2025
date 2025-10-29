class Archivo {

    const nombre
    var contenido = ""

    method seLlama(nombreArchivo) {
        return nombre == nombreArchivo
    }

    method agregarContenido(texto) {
        contenido = contenido + texto
    }

    method sacarContenido(texto) {
        contenido = contenido - texto
        // Esto no funciona ni en pedo, pero no me interesa resolverlo ahora
    }

}