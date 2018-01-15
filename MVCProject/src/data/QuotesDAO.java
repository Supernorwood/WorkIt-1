package data;

import entities.Quotes;

public interface QuotesDAO {
	
	public Quotes getQuoteById(int quoteId);
	
	public Quotes addQuote(String quoteJson);
	
	public Quotes updateQuote(int quoteId, String quoteJson);
	
	public Boolean destroyQuote(int quoteId);



}
