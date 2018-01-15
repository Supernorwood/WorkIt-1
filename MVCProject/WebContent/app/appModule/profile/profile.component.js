angular.module('appModule')
	.component('profile', {
		templateUrl : 'app/appModule/profile/profile.component.html',
		controllerAs : 'vm',
		controller : function(authService, $filter, $routeParams, $location, $cookies){
			var vm = this;
			
			vm.currentUser = null;
			
			var reloadUser = function() {
				currentUser = authService.getToken()
			}
			
			reloadUser();
			
			vm.updateUser = function(userJson) {
				authService.update(userJson).then(function(response) {
					reloadUser();
				})
				.catch(console.error)
			}
			
			vm.deleteUser = function() {
				authService.destroy(currentUser.id).then(function(response) {
					
				})
				.catch(console.error)
			}
			
			
		}
	
		
	
	})