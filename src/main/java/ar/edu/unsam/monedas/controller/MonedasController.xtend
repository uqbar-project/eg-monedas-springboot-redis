package ar.edu.unsam.monedas.controller

import ar.edu.unsam.monedas.dao.MonedasRepository
import ar.edu.unsam.monedas.domain.Moneda
import ar.edu.unsam.monedas.dto.Conversion
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = "*")
class MonedasController {

	@Autowired
	MonedasRepository monedasRepository

	@GetMapping("/monedas")
	@ApiOperation("Recupera información de los valores de cada moneda.")
	def getMonedas() {
		this.monedasRepository.findAll
	}

	@PutMapping("/monedaAPesos/")
	@ApiOperation("Convierte un valor de una moneda determinada a pesos. Para conocer la lista de monedas disponibles tenés el endpoint /GET. Se distinguen mayúsculas de minúsculas. Ejemplo: si 1 zloty está 24 pesos, al convertir 10 zlotys obtendremos 240 pesos.")
	def getMonedasAPesos(@RequestBody Conversion conversion) {
		conversion.moneda.convertirAPesos(conversion.valorAConvertir)
	}

	@PutMapping("/pesosAMoneda/")
	@ApiOperation("Convierte un valor en pesos a una moneda determinada a pesos. Para conocer la lista de monedas disponibles tenés el endpoint /GET. Se distinguen mayúsculas de minúsculas. Ejemplo: si 1 zloty está 24 pesos, al convertir 12 pesos obtendremos 0.5 zlotys.")
	def getPesosAMonedas(@RequestBody Conversion conversion) {
		conversion.moneda.convertirDePesosAMoneda(conversion.valorAConvertir)
	}
	
	protected def Moneda getMoneda(Conversion conversion) {
		this.monedasRepository.findById(conversion.monedaAConvertir).orElseThrow [ new ResponseStatusException(HttpStatus.NOT_FOUND, "La moneda a convertir no existe") ]
	}

}
