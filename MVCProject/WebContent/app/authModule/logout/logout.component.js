angular.module('authModule')
.component('logout', {
	templateUrl : 'app/authModule/logout/logout.component.html',
	controllerAs : 'vm',
	controller : function (authService, $location) {
		var vm = this;
		
		vm.logout = function() {
			authService.logout()
			.then(function(response){
				var current = $location.path();
				if (current === '/jobs') {
					$location,path('/home')
				}
			})
		}
	}
})