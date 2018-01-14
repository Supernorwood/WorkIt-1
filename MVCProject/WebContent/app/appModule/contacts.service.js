angular.module('appModule')
	.factory('contactsService', function($http, $filter, authService, $location) {
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
	  
	  service.index = function() {
		  var user = checkLogin();
		  if (!user) return;
		  return $http({
			  method : 'GET',
			  url : 'rest/user/' + user.id + '/contacts/'
		  });
	  };
	  
	  service.show = function(contactId) {
		  var user = checkLogin();
		  if (!user) return;
		  return $http({
			  method : 'GET',
			  url : 'rest/user/' + user.id + '/contacts/' + contactId
		  });
	  };
	  
	  service.create = function(contact) {
		  var user = checkLogin();
		  if (!user) return;
		  contact.createDate = $filter('date')(Date.now(), 'yyyy-MM-dd');
		  contact.user = user;
		  return $http({
				method : 'POST',
				url : 'rest/user/' + user.id + '/contacts',
				headers : {
					'Content-Type' : 'application/json'
				},
				data : contact
			})
		};
		
		service.destroy = function(contactId) {
			var user = checkLogin();
			  if (!user) return;
				return $http({
					method : 'DELETE',
					url : 'rest/user/' + user.id + '/contacts/' + contactId
				});
			}
		
		service.update = function(contact) {
			var user = checkLogin();
			if (user) {
				return $http({
					method : 'PUT',
					url : 'rest/user/' + user.id + '/contacts/' + contact.id,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : contact
					
				})
			}
		}
	  return service;
	})