object soliamMurr {
    
    const referencias = ["El primer exiliado","El último de su nombre","Soliam Murr"]

    method esReferenciadoPor(titulo) {
        return referencias.any{referencia => titulo.contains(referencia)}
    }

}