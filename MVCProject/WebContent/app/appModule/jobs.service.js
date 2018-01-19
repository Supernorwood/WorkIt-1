angular.module('appModule')
.factory('jobsService', function($http, $filter, authService, $location) {
  var service = {};

  var jobs = [];
  
  var quote = [];
  
  var event = [];
  
  var skills = [];

  var checkLogin = function(user) {
	  var user = authService.getToken()
	  if (!user) {
		  $location.path('/');
		  return;
	  }
	  else {
		  return user;
	  }
  }
  
  service.index = function() {
	  var user = checkLogin();
	  if (!user) return;
	  return $http({
		  method : 'GET',
		  url : 'rest/user/' + user.id + '/jobs'
	  });
  };
  
  service.show = function(id) {
	  var user = checkLogin();
	  
	  if (!user) return;
	  return $http({
		  method : 'GET',
		  url : 'rest/user/' + user.id + '/jobs/' + id //do we need the id of the job after /jobs/ since it's passed in?
	  });
  };
  
  service.create = function(job) {
	  var user = checkLogin();
	  if (!user) return;
	  job.createdDate = $filter('date')(Date.now(), 'yyyy-MM-dd');
	  console.log(job.createdDate);
	  job.active = 1;
	  return $http({
			method : 'POST',
			url : 'rest/user/' + user.id + '/jobs',
			headers : {
				'Content-Type' : 'application/json'
			},
			data : job
		})
	};
	
	service.destroy = function(jobId) {
		var user = checkLogin();
		console.log(jobId);
		  if (!user) return;
			return $http({
				method : 'DELETE',
				url : 'rest/user/' + user.id + '/jobs/' + jobId
			});
		}
	
	service.update = function(jobs) {
		var user = checkLogin();
		if (user) {
			if(jobs.active) {
			jobs.lastUpdate = $filter('date')(Date.now(), 'yyyy-MM-dd');
			}
			console.log(jobs);
			return $http({
				method : 'PUT',
				url : 'rest/user/' + user.id + '/jobs/' + jobs.id,
				headers : {
					'Content-Type' : 'application/json'
				},
				data : jobs
				
			})
		}
	}
	
	service.getJobSkills = function(jobId) {
		var user = checkLogin();
		return $http({
			method: 'GET',
			url: 'rest/user/' + user.id + '/jobs/' + jobId + '/skills'
		})
		.catch(console.error)
	}
	
	service.getQuote = function(quote) {
		return $http({
			  method : 'GET',
			  url : 'rest/quotes/random' 
		  });
		
	}
	
	service.getEvents = function(event) {
		var user = checkLogin();
		if (!user) return;
		return $http({
			method : 'GET',
			url : 'rest/user/' + user.id + '/events/' 
		})
	}
	
	service.showEvent = function(event) {
		var user = checkLogin();
		if (!user) return;
		return $http({
			method : 'GET',
			url : 'rest/user/' + user.id + '/events/' + id 
		});
	}
	
	service.addEvent = function(event) {
		var user = checkLogin();
		if (!user) return;
		console.log(event)
		return $http({
			method : 'POST',
			url : 'rest/user/' + user.id + '/events',
			headers : {
				'Content-Type' : 'application/json'
			},
			data : event
		})
	}
	
	service.updateEvent = function(event) {
		var user = checkLogin();
		if (user) {
			console.log(event);
			return $http({
				method : 'PUT',
				url : 'rest/user/' + user.id + '/events/' + events.id,
				headers : {
					'Content-Type' : 'application/json'
				},
				data : events
			})
		}
	}
	
	service.destroyEvent = function(event) {
		var user = checkLogin();
		  if (!user) return;
			return $http({
				method : 'DELETE',
				url : 'rest/user/' + user.id + '/event/' + event
			});
	}
	
	service.destroySkill = function(sid) {
		var user = checkLogin();
		return $http({
			method : 'DELETE',
			url : 'rest/user/' + user.id + '/skill/' + sid
		})
	}
	
	service.destroyJobSkill = function(sid) {
		var user = checkLogin();
		return $http({
			method : 'DELETE',
			url : 'rest/user/' + user.id + '/jobs/' + job.id + '/skill/' + sid
		})
	}
	
	service.getAllSkills = function(sid) {
		var user = checkLogin();
		return $http({
			method : 'GET',
			url : 'rest/user/' + user.id + '/skill/' 
		})
	}
	
	service.addASkill = function(sid) {
		var user = checkLogin();
		if (!user) return;
		console.log(skills)
		return $http({
			method : 'POST',
			url : 'rest/user/' + user.id + '/skill',
			headers : {
				'Content-Type' : 'application/json'
			},
			data : skills
		})
	}
	
  return service;
})