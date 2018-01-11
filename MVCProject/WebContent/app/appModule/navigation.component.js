angular.module('appModule')
	.component('navigation', {
		templateUrl : 'app/appModule/navigation.component.html',
		controllerAs : 'vm',
		controller : function(authService, $location){	
			
			var vm = this;
	
			vm.loggedIn = function(){
				if(!authService.getToken().id){
					$location.path('/login')
					return false;
				}
				return true;
			}
		}
	})