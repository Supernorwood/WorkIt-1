package data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import entities.Quotes;


@Transactional
@Repository
public class QuotesDAOImpl implements QuotesDAO {

	@PersistenceContext
	private EntityManager em;
	
	
	@Override
	public Quotes getQuoteById(int quoteId) {
		return em.find(Quotes.class, quoteId);
	}

	
}
