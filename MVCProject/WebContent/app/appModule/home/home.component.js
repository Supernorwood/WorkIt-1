angular.module('appModule').component('home', {
	templateUrl : 'app/appModule/home/home.component.html',
	controller : function(authService, $location, jobsService) {
		var vm = this;

		vm.quoteOfTheDay = 'chill';

		vm.loggedIn = function() {
			if (authService.getToken().id) {
				return true;
			}
			return false;
		}

		vm.showQuote = function() {
			jobsService.getQuote().then(function(response) {
				vm.quoteOfTheDay = response.data
			})
		}
		vm.showQuote();
		
		
	},

	controllerAs : 'vm',

})