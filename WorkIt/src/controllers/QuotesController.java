package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import data.QuotesDAO;
import entities.Quotes;

@RestController
public class QuotesController {
	
	@Autowired
	QuotesDAO quotesDao;
	
	//GET /quotes/{quoteId}
	@RequestMapping(path = "/quotes/{quoteId}", method = RequestMethod.GET)
	public Quotes getQuoteById(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int quoteId) {
		return quotesDao.getQuoteById(quoteId);
	}
	
	@RequestMapping(path = "/quotes/random", method = RequestMethod.GET)
	public Quotes getRandomQuote(HttpServletRequest req, HttpServletResponse res) {
		int quoteIdRandom = (int) Math.floor(22 * Math.random());
		return quotesDao.getQuoteById(quoteIdRandom);
	
	}

}
