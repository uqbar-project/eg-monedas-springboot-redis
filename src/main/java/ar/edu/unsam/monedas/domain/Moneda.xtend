package ar.edu.unsam.monedas.domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.springframework.data.annotation.Id
import org.springframework.data.redis.core.RedisHash

import static extension ar.edu.unsam.monedas.domain.NumberUtil.*

@RedisHash("Moneda")
@Accessors
class Moneda {
	@JsonIgnore
	BigDecimal cotizacionMoneda
	
	@Id
	String descripcion
	
	def convertirAPesos(BigDecimal unValor) {
		unValor * cotizacionMoneda
	}
	
	def convertirDePesosAMoneda(BigDecimal unValor) {
		unValor / cotizacionMoneda
	}
		
	def getCotizacionDeMoneda() {
		cotizacionMoneda.format
	}
	
}