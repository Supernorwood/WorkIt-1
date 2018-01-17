angular.module('appModule',['ngRoute', 'authModule', 'ui.bootstrap', 'ui.calendar'])
.config(function($routeProvider){
	$routeProvider
		.when('/', {
			template : '<home></home>'
		})
		.when ('/profile', {
			template : '<profile></profile>'
		})
		.when ('/register', {
			template : '<register></register>'
		})
		.when ('/login', {
			template : '<login></login>'
		})
		.when ('/logout', {
			template : '<logout></logout>'
		})
		.when ('/jobs', {
			template : '<jobs></jobs>'
		})
		.when ('/contacts', {
			template : '<contacts></contacts>'
		})
		.when ('/calendar', {
			template : '<calendar></calendar>'
		})
		.when('/error', {
			template: '<error></error>'
		})
		.otherwise ({
			template : '<error></error>'
		})
})