angular.module('authModule')
.factory('authService', function($http, $cookies, $location) {
    var service = {};
    
    service.getToken = function() {
        var user = {};
        user.id = $cookies.get('uid');
        user.email = $cookies.get('userEmail');
        user.firstName = $cookies.get('userFirstName');
        user.lastName = $cookies.get('userLastName');
        user.address = $cookies.get('userAddress');
        return user;
    }

    var saveToken = function(user) {
        $cookies.put('uid', user.id);
        $cookies.put('userEmail', user.email);
        $cookies.put('userFirstName', user.firstName);
        $cookies.put('userLastName', user.lastName);
        $cookies.put('userAddress', user.address);
    }
    
    var removeToken = function() {
    		$cookies.remove('uid');
    		$cookies.remove('userEmail');
    		$cookies.remove('userFirstName');
    		$cookies.remove('userLastName');
    		$cookies.remove('userAddress');
    		$location.path('/');
    }    
        
    service.register = function(user) {
        return $http({
            method : 'POST',
            url : 'rest/auth/register',
            headers :  {
                'Content-Type' : 'application/json'
            },
            data : user
        })
        .then(function(response) {
            saveToken(response.data)
        })
        .catch(console.error)
    }
    
    service.login = function(user) {
    		return $http({
    			method : 'POST',
    			url : 'rest/auth/login',
    			headers : {
    				'Content-Type' : 'application/json'
    			},
    			data: user
    		})
    		.then(function(response){
    			saveToken(response.data)
    		})
    		.catch(console.error)
    }
    
    service.logout = function() {
    		return $http({
    			method : 'POST',
    			url : 'rest/auth/logout',

    		})
    		.then(function(response){
    			removeToken();
    		})
    		.catch(console.error)
    }
    
    service.update = function(user) {
    		return $http({
    			method: 'PUT',
    			url: 'rest/auth/' + user.id,
    			headers: {
    				'Content-Type': 'application/json'
    			},
    			data: user
    		})
    		.then(function(response) {
    			saveToken(response.data)
    		})
    		.catch(console.error)
    }
    
    service.destroy = function(userId) {
    		return $http({
    			method: 'DELETE',
    			url: 'rest/auth/' + userId
    		})
    		.then(function(response) {
    			removeToken()
    		})
    		.catch(console.error)
    }
    
    return service;
})