angular.module('appModule',['ngRoute', 'authModule'])
.config(function($routeProvider){
	$routeProvider
		.when('/home', {
			template : '<home-component></home-component>'
		})
		.when ('/about', {
			template : '<about-component></about-component>'
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
		}
		.otherwise ({
			template : '<error></error>'
		})
})