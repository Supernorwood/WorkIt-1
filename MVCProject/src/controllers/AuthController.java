package controllers;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import data.AuthDAO;
import entities.User;

@RestController
public class AuthController {
  
  @Autowired
  private AuthDAO authDAO;

  @RequestMapping(path = "/auth/register", method = RequestMethod.POST)
  public User register(HttpSession session, HttpServletResponse res, @RequestBody String userJson) {
	  ObjectMapper mapper = new ObjectMapper();
	  User registeredUser = null;
	  try {
		  registeredUser = mapper.readValue(userJson, User.class);
	  }
	  catch (Exception e) {
		  e.printStackTrace();
	  }
    registeredUser = authDAO.register(registeredUser);
    if (registeredUser == null) {
    		res.setStatus(400);
    		return null;
    }
    session.setAttribute("user", registeredUser);
    return registeredUser;
  }
  
  @RequestMapping(path = "/auth/login", method = RequestMethod.POST)
  public User login(HttpSession session, HttpServletResponse res, @RequestBody String userJson) {
	  ObjectMapper mapper = new ObjectMapper();
	  User loggedInUser = null;
	  
	  try {
		  loggedInUser = mapper.readValue(userJson, User.class);
	  }
	  catch (Exception e) {
		  e.printStackTrace();
	  }
	  loggedInUser = authDAO.login(loggedInUser);
	  if (loggedInUser == null) {
		  res.setStatus(401);
		  return null;
	  }
	  session.setAttribute("user", loggedInUser);
	  return loggedInUser;
  }
  
  @RequestMapping(path = "/auth/logout", method = RequestMethod.POST)
  public Boolean logout(HttpSession session, HttpServletResponse response) {
	  session.removeAttribute("user");
	  if (session.getAttribute("user") != null) {
		  return false;
	  }
	  return true;
  }
  
  @RequestMapping(path = "/auth/unauthorized")
  public String unauth(HttpServletResponse response) {
    response.setStatus(401);
    return "unauthorized";
  }
  
  @RequestMapping(path = "/auth/{userId}", method = RequestMethod.PUT)
  public User updateUser(HttpSession session, HttpServletResponse res, @PathVariable int userId, @RequestBody String userJson) {
	  return authDAO.updateUser(userId, userJson);
  }
  
  @RequestMapping(path = "/auth/{userId}", method = RequestMethod.DELETE)
  public Boolean destroyUser(HttpSession session, HttpServletResponse res, @PathVariable int userId) {
	  return authDAO.destroyUser(userId);
  }
}