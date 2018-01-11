angular.module('appModule',['ngRoute', 'authModule'])
.config(function($routeProvider){
	$routeProvider
		.when('/home', {
			template : '<home></home>'
		})
		.when ('/about', {
			template : '<about></about>'
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
		.when('/error', {
			template: '<error></error>'
		})
		.otherwise ({
			template : '<error></error>'
		})
})