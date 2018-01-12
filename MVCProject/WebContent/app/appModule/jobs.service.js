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
  
  service.create = function(jobs) {
	  var user = checkLogin();
	  if (!user) return;
	  job.status=false;
	  return $http({
			method : 'POST',
			url : 'rest/user/' + user.id + '/jobs',
			headers : {
				'Content-Type' : 'application/json'
			},
			data : jobs
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
		if (checkLogin()) {
			if(jobs.completed) {
			completeDate = $filter('date')(Date.now(), 'MM/dd/yyyy');
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