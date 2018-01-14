angular.module('appModule')
	.factory('addressesService', function($http, $filter, authService, $location) {
	  var service = {};
	
	  var checkLogin = function(user) {
		  var user = authService.getToken()
		  if (!user) {
			  $location.path('/home');
			  return;
		  }
		  else {
			  return user;
		  }
	  }
	  
	  service.show = function(addressId) {
		  var user = checkLogin();
		  if (!user) return;
		  return $http({
			  method : 'GET',
			  url : 'rest/address/' + addressId
		  });
	  };
	  
	  service.create = function(address) {
		  var user = checkLogin();
		  if (!user) return;
		  return $http({
				method : 'POST',
				url : 'rest/address/',
				headers : {
					'Content-Type' : 'application/json'
				},
				data : address
			})
		};
		
		service.destroy = function(addressId) {
			var user = checkLogin();
			  if (!user) return;
				return $http({
					method : 'DELETE',
					url : 'rest/address/' + addressId
				});
			}
		
		service.update = function(address) {
			var user = checkLogin();
			if (user) {
				return $http({
					method : 'PUT',
					url : 'rest/address/' + address.id,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : address
					
				})
			}
		}
	  return service;
	})