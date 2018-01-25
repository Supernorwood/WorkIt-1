angular.module('appModule')
	.factory('eventService', function($http, $filter, $cookies, $location) {
		var service = {};
		
		service.getEvents = function(event) {
			var userId = $cookies.get('uid');
			if (!user) return;
			return $http({
				method : 'GET',
				url : 'rest/user/' + userId + '/events' 
			})
		}
		
		service.showEvent = function(event) {
			var userId = $cookies.get('uid');
			if (!user) return;
			return $http({
				method : 'GET',
				url : 'rest/user/' + userId + '/events/' + id 
			});
		}
		
		service.addEvent = function(event) {
			var userId = $cookies.get('uid');
			if (!user) return;
			console.log(event)
			return $http({
				method : 'POST',
				url : 'rest/user/' + userId + '/events',
				headers : {
					'Content-Type' : 'application/json'
				},
				data : event
			})
		}
		
		service.updateEvent = function(event) {
			var userId = $cookies.get('uid');
			if (user) {
				console.log(event);
				return $http({
					method : 'PUT',
					url : 'rest/user/' + userIdd + '/events/' + events.id,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : events
				})
			}
		}
		
		service.destroyEvent = function(event) {
			var userId = $cookies.get('uid');
			  if (!user) return;
				return $http({
					method : 'DELETE',
					url : 'rest/user/' + userId + '/event/' + event
				});
		}
		
	})
	