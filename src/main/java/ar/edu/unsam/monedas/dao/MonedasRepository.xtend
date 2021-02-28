package ar.edu.unsam.monedas.dao

import ar.edu.unsam.monedas.domain.Moneda
import org.springframework.data.repository.CrudRepository

interface MonedasRepository extends CrudRepository<Moneda, String> {}