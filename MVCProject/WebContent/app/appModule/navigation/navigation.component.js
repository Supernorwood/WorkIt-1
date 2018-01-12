angular.module('appModule')
	.component('navigation', {
		templateUrl : 'app/appModule/navigation/navigation.component.html',
		controllerAs : 'vm',
		controller : function(authService, $location){	
			
			var vm = this;
	
		vm.loggedIn = function() {
			if (authService.getToken()){
				return true;
			}
			return false;
			}
		}
	})