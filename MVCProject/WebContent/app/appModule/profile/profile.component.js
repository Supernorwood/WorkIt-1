angular.module('appModule')
	.component('profile', {
		templateUrl : 'app/appModule/profile/profile.component.html',
		
		controller : function(authService, addressesService, $filter, $routeParams, $location, $cookies){
			var vm = this;
			
			vm.currentUser = null;
			
			vm.infoUpdated = false;
			
			var reloadUser = function() {
				vm.currentUser = authService.getToken();
			}
			
			reloadUser();
			
			vm.updateUser = function() {
				authService.update(vm.currentUser).then(function(response) {
					reloadUser();
				})
				.catch(console.error)
			}
			
			vm.deleteUser = function() {
				authService.destroy(currentUser.id).then(function(response) {
					
				})
				.catch(console.error)
			}
			
			
		},
		controllerAs : 'vm'
	
	})