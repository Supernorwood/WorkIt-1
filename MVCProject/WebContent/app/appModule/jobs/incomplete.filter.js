angular.module('appModule')
.filter('incompleteFilter', function() {
	return function(jobs, showComplete) {
		var jobs = [];
		if(showComplete) {
			return jobs;
		}
		else {
		return jobs.filter(function(jobs) {
				return !jobs.completed;
			
		})
		}
	}
	
})