angular.module('appModule')
	.component('home', {
		templateUrl : 'app/appModule/home/home.component.html',
		controller : function(authService, $location){
			var vm = this;

				vm.loggedIn = function() {
		if (authService.getToken().id) {
			return true;
		}
		return false;
	}
},
	
	controllerAs : 'vm',
	
})