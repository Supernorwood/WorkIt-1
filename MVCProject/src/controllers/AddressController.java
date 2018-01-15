package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import data.AddressDAO;
import entities.Address;

@RestController
public class AddressController {

	@Autowired
	AddressDAO addressDao;
	
	//GET /address/{addressId}
	@RequestMapping(path = "/address/{addressId}", method = RequestMethod.GET)
	public Address getAddressById(HttpServletRequest req, HttpServletResponse res,
			@PathVariable int addressId) {
		return addressDao.getAddressById(addressId);
	}
	
	//POST /address/{addressId}
	@RequestMapping(path = "/address/{addressId}", method = RequestMethod.POST)
	public Address createAddress(HttpServletRequest req, HttpServletResponse res, @RequestBody String addressJson) {
		return addressDao.createAddress(addressJson);
	}
	
	//PUT /address/{addressId}
	@RequestMapping(path = "/address/{addressId}", method = RequestMethod.PUT)
	public Address updateAddress(HttpServletRequest req, HttpServletResponse res, 
			@PathVariable int addressId, @RequestBody String addressJson) {
		System.out.println(addressJson);
		return addressDao.updateAddress(addressId, addressJson);
	}
	
	//DELETE /address/{addressId}
	@RequestMapping(path = "/address/{addressId}", method = RequestMethod.DELETE)
	public Boolean destroyAddress(HttpServletRequest req, HttpServletResponse res, @PathVariable int addressId) {
		return addressDao.destroyAddress(addressId);
	}
}
