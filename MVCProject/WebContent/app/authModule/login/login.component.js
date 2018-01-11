angular.module('authModule')
.component('login', {
	templateUrl : 'app/authModule/login/login.component.html',
	controllerAs : 'vm',
	controller : function(authService, $location) {
		var vm = this;

		vm.loginUser = function(user) {
			authService.login(user).then(function(response) {
				$location.path('/jobs')
			})

		}
	}
})