package ar.edu.unsam.monedas

import ar.edu.unsam.monedas.dao.MonedasRepository
import ar.edu.unsam.monedas.domain.Moneda
import java.math.BigDecimal
import org.springframework.beans.factory.InitializingBean
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class MonedasBootstrap implements InitializingBean {

	@Autowired
	MonedasRepository monedasRepository
	
	def initMonedas() {
		crearMoneda("24.01", "Zloty")
		crearMoneda("1.22", "Rupia india")
		crearMoneda("6.35", "Florín")
	}
	
	protected def Moneda crearMoneda(String valor, String descripcionMoneda) {
		monedasRepository.save(new Moneda => [
			cotizacionMoneda = new BigDecimal(valor)
			descripcion = descripcionMoneda
		])
	}

	override afterPropertiesSet() throws Exception {
		println("************************************************************************")
		println("Running initialization")
		println("************************************************************************")
		initMonedas
	}

}
