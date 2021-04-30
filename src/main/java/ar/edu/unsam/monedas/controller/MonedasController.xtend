package ar.edu.unsam.monedas.controller

import ar.edu.unsam.monedas.dto.Conversion
import ar.edu.unsam.monedas.service.MonedasService
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class MonedasController {

	@Autowired
	MonedasService monedasService

	@GetMapping("/monedas")
	@ApiOperation("Recupera información de los valores de cada moneda.")
	def getMonedas() {
		monedasService.getMonedas()
	}

	@PutMapping("/monedaAPesos/")
	@ApiOperation("Convierte un valor de una moneda determinada a pesos. Para conocer la lista de monedas disponibles tenés el endpoint /GET. Se distinguen mayúsculas de minúsculas. Ejemplo: si 1 zloty está 24 pesos, al convertir 10 zlotys obtendremos 240 pesos.")
	def getMonedasAPesos(@RequestBody Conversion conversion) {
		monedasService.convertirMonedaAPesos(conversion)
	}

	@PutMapping("/pesosAMoneda/")
	@ApiOperation("Convierte un valor en pesos a una moneda determinada a pesos. Para conocer la lista de monedas disponibles tenés el endpoint /GET. Se distinguen mayúsculas de minúsculas. Ejemplo: si 1 zloty está 24 pesos, al convertir 12 pesos obtendremos 0.5 zlotys.")
	def getPesosAMonedas(@RequestBody Conversion conversion) {
		monedasService.convertirPesosAMoneda(conversion)
	}
	
}
