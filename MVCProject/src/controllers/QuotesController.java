package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	//POST /quotes/{quoteId}
	@RequestMapping(path = "/quotes/{quoteId}", method = RequestMethod.POST)
	public Quotes addQuote(HttpServletRequest req, HttpServletResponse res,
			@RequestBody String quoteJson) {
		return quotesDao.addQuote(quoteJson);
	}
	
	//PUT /quotes/{quoteId}
}
