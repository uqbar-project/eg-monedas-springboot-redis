package ar.edu.unsam.monedas

import ar.edu.unsam.monedas.dto.Conversion
import java.math.BigDecimal
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders

import static ar.edu.unsam.monedas.TestHelpers.*
import static org.junit.jupiter.api.Assertions.assertEquals

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@DisplayName("Dado un controller de monedas")
class MonedasControllerTest {
    @Autowired
    MockMvc mockMvc

    @Test
    @DisplayName("podemos convertir de una moneda a pesos")
    def void conversionAPesos() {
        val conversion = new Conversion => [
        	valorAConvertir = new BigDecimal(10)
        	monedaAConvertir = "Zloty"
        ]
        val responseEntity = mockMvc.perform(
            MockMvcRequestBuilders.put('''/monedaAPesos/''')
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(conversion))
        ).andReturn().response
				assertEquals(200, responseEntity.status)
				assertEquals("240.10", responseEntity.contentAsString)
    }

    @Test
    @DisplayName("podemos convertir de pesos a una moneda")
    def void conversionAMoneda() {
        val conversion = new Conversion => [
        	valorAConvertir = new BigDecimal(48.02)
        	monedaAConvertir = "Zloty"
        ]
        val responseEntity = mockMvc.perform(
            MockMvcRequestBuilders.put('''/pesosAMoneda/''')
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(conversion))
        ).andReturn().response
				assertEquals(200, responseEntity.status)
				assertEquals("2.00", responseEntity.contentAsString)
    }

    @Test
    @DisplayName("no podemos convertir de una moneda inexistente")
    def void conversionAMonedaInexistente() {
        val conversion = new Conversion => [
        	valorAConvertir = new BigDecimal(48.02)
        	monedaAConvertir = "patacones"
        ]
        val responseEntity = mockMvc.perform(
            MockMvcRequestBuilders.put('''/pesosAMoneda/''')
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(conversion))
        ).andReturn().response
				assertEquals(404, responseEntity.status)
    }

}
