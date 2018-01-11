angular.module('authModule')
.component('register', {
	templateUrl : 'app/authModule/register/register.component.html',
	controllerAs : 'vm',
	controller : function (authService, $location) {
		var vm = this;
		
		vm.registerUser = function(user) {
			console.log(user);
			if (user.password === user.confirm) {
				authService.register(user)
				.then(function(response){
					$location.path('/jobs')
				})
			} else {
				console.log("PASSWORDS DO NOT MATCH")
			}
		}
	}
})