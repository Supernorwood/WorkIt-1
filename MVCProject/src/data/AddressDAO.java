package data;

import entities.Address;

public interface AddressDAO {

	public Address getAddressById(int addressId);
	
	public Address createAddress(String addressJson);
	
	public Address updateAddress(int addressId, String addressJson);
	
	public Boolean destroyAddress(int addressId);
}
