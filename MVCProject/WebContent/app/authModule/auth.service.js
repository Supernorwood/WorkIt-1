angular.module('authModule')
.factory('authService', function($http, $cookies, $location) {
    var service = {};
    
    service.getToken = function() {
        var user = {};
        user.id = $cookies.get('uid');
        return user;
    }

    var saveToken = function(user) {
        $cookies.put('uid', user.id);
        $cookies.put('userEmail', user.email);
    }
    
    var removeToken = function() {
    		$cookies.remove('uid');
    		$cookies.remove('userEmail');
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
    			removeToken()
    		})
    		.catch(console.error)
    }
    
    return service;
})