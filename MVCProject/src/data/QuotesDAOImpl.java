package data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

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

	@Override
	public Quotes addQuote(String quoteJson) {
		ObjectMapper mapper = new ObjectMapper();
		Quotes newQuote = null;
		
		try {
			newQuote = mapper.readValue(quoteJson, Quotes.class);
			em.persist(newQuote);
			em.flush();
			return newQuote;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Quotes updateQuote(int quoteId, String quoteJson) {
		ObjectMapper mapper = new ObjectMapper();
		Quotes managedQuote = em.find(Quotes.class, quoteId);
		Quotes updateQuote = null;
		
		try {
			updateQuote = mapper.readValue(quoteJson, Quotes.class);
			managedQuote.setQuote(updateQuote.getQuote());
			managedQuote.setAuthor(updateQuote.getAuthor());
			return managedQuote;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public Boolean destroyQuote(int quoteId) {
		String query = "DELETE FROM Address Where id = :quoteId";
		em.createQuery(query).setParameter("quoteId", quoteId).executeUpdate();
		return !em.contains(em.find(Quotes.class, quoteId));
	}

}
