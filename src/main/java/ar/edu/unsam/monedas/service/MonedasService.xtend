package ar.edu.unsam.monedas.service

import ar.edu.unsam.monedas.dao.MonedasRepository
import ar.edu.unsam.monedas.domain.Moneda
import ar.edu.unsam.monedas.dto.Conversion
import ar.edu.unsam.monedas.errorHandling.NotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class MonedasService {
	
	@Autowired
	MonedasRepository monedasRepository

	def getMonedas() {
		this.monedasRepository.findAll
	}

	protected def Moneda getMoneda(Conversion conversion) {
		monedasRepository
			.findById(conversion.monedaAConvertir)
			.orElseThrow [ new NotFoundException("La moneda a convertir no existe") ]
	}
	
	def convertirMonedaAPesos(ar.edu.unsam.monedas.dto.Conversion conversion) {
		conversion.moneda.convertirAPesos(conversion.valorAConvertir)
	}
	
	def convertirPesosAMoneda(ar.edu.unsam.monedas.dto.Conversion conversion) {
		conversion.moneda.convertirDePesosAMoneda(conversion.valorAConvertir)
	}

}