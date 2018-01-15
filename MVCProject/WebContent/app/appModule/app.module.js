angular.module('appModule',['ngRoute', 'authModule'])
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
		.when('/error', {
			template: '<error></error>'
		})
		.otherwise ({
			template : '<error></error>'
		})
})