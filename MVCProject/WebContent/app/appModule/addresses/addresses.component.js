angular.module('appModule')
	.component('addresses', {
		templateUrl : 'app/appModule/addresses.component.html',
		controller : function (addressesService, $filter, $routeParams, $location, $cookies) {
			var vm = this;
			
		},
		controllerAs : "vm"
	})