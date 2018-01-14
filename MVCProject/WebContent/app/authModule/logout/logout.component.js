angular.module('authModule')
.component('logout', {
	templateUrl : 'app/authModule/logout/logout.component.html',
	controllerAs : 'vm',
	controller : function (authService, $location) {
		var vm = this;
		
		vm.logout = function() {
			authService.logout()
			.then(function(response){
				$location.path('/')
			})
		}
	}
})