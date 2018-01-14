 angular.module('appModule')
	.component('jobs', {
		templateUrl : 'app/appModule/jobs/jobs.component.html',
		controller : function (jobsService, $filter, $routeParams, $location, $cookies) {
			var vm = this;
			
			vm.selected = null;
			
			vm.editJob = null;
			
			vm.jobs = [];
			
			vm.showAllJobs = false;
			
			var reloadJobs = function() {
				jobsService.index()
				.then(function(response) {
					vm.jobs = response.data;
				}) 
				.catch(console.error)

			}
			reloadJobs();
			
			vm.addJob = function(job) {
				jobsService.create(job)
				.then(function(response){
					reloadJobs();
				})
				.catch(console.error)
			}
			
			vm.displayJob = function(job){
				return vm.selected = job;
			}
			
			vm.displayAllJobs = function() {
	            vm.selected = null;
	        }
			
			vm.updateJob = function(edittedJob) {
				jobsService.update(edittedJob)
				.then(function(response){
					reloadJobs();
					vm.selected = vm.editJob;
					vm.editJob = null;
				})
				.catch(console.error)
			}
			
			vm.destroyJob = function(id) {
				console.log(id);
				jobsService.destroy(id)
				.then(function(response){
					reloadJobs();
				})
				.catch(console.error)
			}
			
			vm.setEditJob= function() {
                vm.editJob = angular.copy(vm.selected);
			}
			
			var incomplete = $filter('incompleteFilter')(vm.jobs);
			
			if (!vm.selected && parseInt($routeParams.jobId)){
					jobsService.show($routeParams.jobId)
						.then(function(response){
							console.log(response)
							vm.selected = response.data;
				})
				.catch(function(response){
					$location.path('/error');
				}) 
			}

//			if (!vm.selected && parseInt($routeParams.id)) {
//				  vm.selectedJob(parseInt($routeParams.id));
//				  
//			}
			
			
//			vm.getJobNumber = function(jobs) {
//				return $filter('incompleteFilter')(vm.jobs).length
//			}
			
		},
		controllerAs : "vm"
	})