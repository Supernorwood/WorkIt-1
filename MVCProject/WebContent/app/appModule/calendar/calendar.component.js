angular.module('appModule').component('calendar', {
	templateUrl : 'app/appModule/calendar/calendar.component.html',
	controller : function(authService, $location, jobsService) {
		var vm = this;


		vm.uiConfig = {
			      calendar:{
			          height: 450,
			          editable: true,
			          header:{
			            left: 'month basicWeek basicDay agendaWeek agendaDay',
			            center: 'title',
			            right: 'today prev,next'
			          },
			        }
			      };
// test data
	    var date = new Date();
	    var d = date.getDate();
	    var m = date.getMonth();
	    var y = date.getFullYear();
		
		vm.events = [
		      {title: 'All Day Event',start: new Date(y, m, 1)},
		      {title: 'Long Event',start: new Date(y, m, d - 5),end: new Date(y, m, d - 2)},
		      {id: 999,title: 'Repeating Event',start: new Date(y, m, d - 3, 16, 0),allDay: false},
		      {id: 999,title: 'Repeating Event',start: new Date(y, m, d + 4, 16, 0),allDay: false},
		      {title: 'Birthday Party',start: new Date(y, m, d + 1, 19, 0),end: new Date(y, m, d + 1, 22, 30),allDay: false},
		    ];
	},

	controllerAs : 'vm',

})