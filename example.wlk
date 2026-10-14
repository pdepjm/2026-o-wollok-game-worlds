class Partida {
  const rojo
  const azul
  var seJugo = false

  method jugar() {
    rojo.jugar()
    azul.jugar()
    seJugo = true
  }

  method quienGano() {
    if(!seJugo) throw new DomainException(message="Aún no se jugó la partida")
    return [rojo, azul].max({participante => participante.habilidad()})
  }
}

class Jugador {
  const antiguedad
  var cansancio = 50

  method esTitular() = antiguedad > 3

  method estaTotalmenteCansado() = cansancio > 100

  method tomarBebidaEnergizante(){
    cansancio = 0.max(cansancio - 10)
  }

  method habilidad() = antiguedad * 2 - cansancio

  method jugar(){
    if(!self.puedeJugar()) throw new DomainException(message="El jugador debe ser titular y no estar cansado para jugar")
    cansancio += 20
  }

  method puedeJugar() = self.esTitular() && !self.estaTotalmenteCansado()

  //getter usado para tests
  method cansancio() = cansancio

}

object faker{
  var habilidad = 50
  var tilteado = false

  method jugar(){
    habilidad += 20
  }

  method tiltearse(){
    tilteado = true
  }

  method tomarseUnTecito(){
    tilteado =  false
  }

  method habilidad() = if (tilteado) 0 else habilidad

  //getter usado para tests
  method tilteado() = tilteado

}

class Equipo{
  const integrantes = []

  method habilidad() = integrantes.sum({integrante => integrante.habilidad()})

  method jugar(){
    integrantes.forEach({integrante => integrante.jugar()})
  }
}