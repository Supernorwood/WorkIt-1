 angular.module('appModule')
	.component('jobs', {
		templateUrl : 'app/appModule/jobs/jobs.component.html',
		controller : function (jobsService, $filter, $routeParams, $location, $cookies) {
			var vm = this;
			
			vm.selected = null;
			
			vm.editJob = null;
			
			vm.jobs = [];
			
			vm.showAllJobs = false;
			
			vm.editJobSkills = [];
			
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
                jobsService.getJobSkills(vm.editJob.id).then(function(response) {
                		vm.editJobSkills = response.data
                })
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
			
			vm.countJobs = function() {
				return (vm.jobs).length;
			}
			
			vm.jobsThisWeek = function(job) {
				var results = [];
				var sunday = moment().startOf('week')._d; // === Sun Jan 14 2018 00:00:00 GMT-0700 (MST)
				
				var sundayUTC = moment(sunday).valueOf(); // === 1515913200000
				console.log(sundayUTC);
				
				Date.now(); // === 1516223576344
			
				console.log(Date.now());
				
				if (sundayUTC > Date.now()) {
					
					for (var i = 0; i < vm.jobs.length; i++) {
						if (vm.jobs.createdDate < sudayUTC) {
							results.push(job);
						}	
					}
				
					return results;
				}
			}
				
		
			
			vm.addJobSkill = function() {
				if (vm.editJob.jobSkills.length > 0) {
					vm.editJob.jobSkills.push({
						"skill": ""
					});
				}
				else {
					vm.editJob.jobSkills = [
						{
							"skill" : ""
						}
					];
				}
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