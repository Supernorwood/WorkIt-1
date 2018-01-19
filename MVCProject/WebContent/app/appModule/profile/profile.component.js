angular.module('appModule')
	.component('profile', {
		templateUrl : 'app/appModule/profile/profile.component.html',
		
		controller : function(authService, jobsService, addressesService, $filter, $routeParams, $location, $cookies){
			var vm = this;
			
			vm.currentUser = null;
			
			vm.skill = [];
			
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
			
			vm.seeSkills = function(skill) {
				jobsService.getAllSkills(skill)
				.then(function(response){
					reloadUser();
				})
			}
			
			vm.addSkill = function(skill) {
				jobsService.addASkill(skill)
				.then(function(response){
					reloadUser();
				})
				.catch(console.error)
			}
			
			vm.destroySkill = function(id) {
				console.log(id);
				jobsService.destroySkill(id)
				.then(function(response){
					reloadUser();
				})
				.catch(console.error)
			}
			
			
			
		},
		controllerAs : 'vm'
	
	})