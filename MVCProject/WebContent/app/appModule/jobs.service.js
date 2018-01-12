angular.module('appModule')
.factory('jobsService', function($http, $filter, authService, $location) {
  var service = {};

  var jobs = [];

  var checkLogin = function(user) {
	  var user = authService.getToken()
	  if (!user) {
		  $location.path('/login');
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
		  url : 'rest/user/' + user.id + '/jobs/'
	  });
  };
  
  service.create = function(job) {
	  var user = checkLogin();
	  if (!user) return;
	  job.createDate = $filter('date')(Date.now(), 'yyyy-MM-dd');
	  job.active = 1;
	  job.userId = user.id;
	  return $http({
			method : 'POST',
			url : 'rest/user/' + user.id + '/jobs',
			headers : {
				'Content-Type' : 'application/json'
			},
			data : job
		})
	};
	
	service.destroy = function(jobs) {
		var user = checkLogin();
		  if (!user) return;
			return $http({
				method : 'DELETE',
				url : 'rest/user/' + user.id + '/jobs/' + jobs.id
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
  return service;
})