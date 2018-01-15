angular.module('appModule').component('home', {
	templateUrl : 'app/appModule/home/home.component.html',
	controller : function(authService, $location) {
		var vm = this;

		vm.loggedIn = function() {
			if (authService.getToken().id) {
				return true;
			}
			return false;
		}
		
		vm.showQuote = function(quoteId){
			quoteId = Math.floor(Math.random()*25);
		}
	},

	controllerAs : 'vm',

})