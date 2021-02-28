package ar.edu.unsam.monedas.dto

import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Conversion {
	BigDecimal valorAConvertir
	String monedaAConvertir
}