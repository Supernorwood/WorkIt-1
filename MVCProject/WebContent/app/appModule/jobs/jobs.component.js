angular.module('appModule')
	.component('jobs', {
		templateUrl : 'app/appModule/jobs/jobs.component.html',
		controller : function (jobsService, $filter, $routeParams, $location) {
			var vm = this;
			
			vm.jobs = []
			
			var reload = function() {
				jobeService.index()
				.then(function(response) {
					vm.jobs = response.data;
				}) 
				.catch(console.error)

			}
			reload();
			
			vm.selected = null;
			
			vm.displayJob = function(jobs){
				return vm.selected = jobs
			}
			
			vm.displayTable = function() {
	            vm.selected = null;
	        }
			
			vm.setEditJob= function() {
                vm.editJob = angular.copy(vm.selected);
			}
			
			vm.addJob = function(jobs) {
				jobsService.create(jobs)
				.then(function(response){
					reload()
				})
				.catch(console.error)
			}
			
			vm.destroyJob = function(jobs) {
				jobsService.destroy(jobs)
				.then(function(response){
					reload()
				})
				.catch(console.error)
			}
			
			vm.updateJobs = function(jobs) {
				jobsService.update(jobs)
				.then(function(response){
					reload()
				})
				.catch(console.error)
			}
			
			vm.selectedJob = function(id) {
				jobsService.show(id)
				.then(function(response){
					console.log(response)
					  vm.selected = response.data
				})
				.catch(function(response){
					$location.path('/fjfjfjf');
				}) 
			}

			if (!vm.selected && parseInt($routeParams.id)) {
				  vm.selectedJob(parseInt($routeParams.id));
				  
			}
			
			var incomplete = $filter('incompleteFilter')(vm.jobs);
			
			vm.getJobNumber = function(jobs) {
				return $filter('incompleteFilter')(vm.jobs).length
			}
			
		},
		controllerAs : "vm"
	})