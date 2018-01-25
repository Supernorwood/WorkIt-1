package data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;

import entities.Address;

@Transactional
@Repository
public class AddressDAOImpl implements AddressDAO {

	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Address getAddressById(int addressId) {
		return em.find(Address.class, addressId);
	}

	@Override
	public Address createAddress(String addressJson) {
		ObjectMapper mapper = new ObjectMapper();
		Address newAddress = null;
		
		try {
			newAddress = mapper.readValue(addressJson, Address.class);
			em.persist(newAddress);
			em.flush();
			return newAddress;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Address updateAddress(int addressId, String addressJson) {
		ObjectMapper mapper = new ObjectMapper();
		Address managedAddress = em.find(Address.class, addressId);
		Address updateAddress = null;
		
		try {
			updateAddress = mapper.readValue(addressJson, Address.class);
			managedAddress.setStreet(updateAddress.getStreet());
			managedAddress.setStreet2(updateAddress.getStreet2());
			managedAddress.setCity(updateAddress.getCity());
			managedAddress.setState(updateAddress.getState());
			managedAddress.setZip(updateAddress.getZip());
			managedAddress.setCountry(updateAddress.getCountry());
			return managedAddress;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Boolean destroyAddress(int addressId) {
		String query = "DELETE FROM Address WHERE id = :addressId";
		em.createQuery(query).setParameter("addressId", addressId).executeUpdate();
		return !em.contains(em.find(Address.class, addressId));
	}

}
