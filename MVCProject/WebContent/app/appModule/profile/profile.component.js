angular.module('appModule')
	.component('profile', {
		templateUrl : 'app/appModule/profile/profile.component.html',
		
		controller : function(authService, addressesService, $filter, $routeParams, $location, $cookies){
			var vm = this;
			
			vm.currentUser = null;
			
			vm.currentUserSkills = [];
			
			vm.infoUpdated = false;
			
			var reloadUser = function() {
				authService.getUser().then(function(response) {
					vm.currentUser = response.data;
					authService.getUserSkills().then(function(response) {
						vm.currentUserSkills = response.data;
					});
				});
			}
			
			reloadUser();
			
			vm.updateUser = function() {
				vm.currentUser.userSkills = vm.currentUserSkills;
				authService.update(vm.currentUser).then(function(response) {
					reloadUser();
				})
				.catch(console.error)
			}
			
			vm.deleteUser = function() {
				authService.destroy(vm.currentUser.id).then(function(response) {
					
				})
				.catch(console.error)
			}
			
			vm.addSkill = function() {
				if (vm.currentUserSkills.length > 0) {
					vm.currentUserSkills.push({
						"skill": ""
					});
				}
				else {
					vm.currentUserSkills = [
						{
							"skill" : ""
						}
					];
				}
			}
			
			
		},
		controllerAs : 'vm'
	
	})