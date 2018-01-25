angular.module('appModule').component('navigation', {
	templateUrl : 'app/appModule/navigation/navigation.component.html',
	controller : function(authService, $location) {
		var vm = this;
		vm.loggedIn = function() {
			if (authService.getToken().id) {
				return true;
			}
			return false;
		}
	},

	controllerAs : 'vm'
})