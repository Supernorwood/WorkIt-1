angular.module('appModule').component('calendar', {
	templateUrl : 'app/appModule/calendar/calendar.component.html',
	controller : function(authService, $location, jobsService, uiCalendarConfig) {
		var vm = this;

		vm.newEvent = null;
		
		vm.uiConfig = {
			      calendar:{
			          height: 450,
			          editable: true,
			          header:{
			            left: 'month basicWeek basicDay',
			            center: 'title',
			            right: 'today prev,next'
			          },
			        }
			      };
		//^^This works and displays the calendar
		vm.addEvent = function() {
			jobsService.getDateCreated().then(function(response) {
				vm.newEvent = response.data
			})
		}
		vm.addEvent();
		//^^This does not work. We want it to display numbers on the calendar that represent the number
		//of applications made that day. No luck in getting it to go.
		
		
		//The below were copied from the Angular UI calendar page and appear to not be working either
		
		 /* add and removes an event source of choice */
	    vm.addRemoveEventSource = function(sources,source) {
	      var canAdd = 0;
	      angular.forEach(sources,function(value, key){
	        if(sources[key] === source){
	          sources.splice(key,1);
	          canAdd = 1;
	        }
	      });
	      if(canAdd === 0){
	        sources.push(source);
	      }
	    };
	    /* add custom event*/
	    vm.addEvent = function() {
	      vm.events.push({
	        title: 'Open Sesame',
	        start: new Date(y, m, 28),
	        end: new Date(y, m, 29),
	        className: ['openSesame']
	      });
	    };
	    /* remove event */
	    vm.remove = function(index) {
	      vm.events.splice(index,1);
	    };
	    /* Change View */
	    vm.changeView = function(view,calendar) {
	      uiCalendarConfig.calendars[calendar].fullCalendar('changeView',view);
	    };
	    /* Change View */
	    vm.renderCalender = function(calendar) {
	      if(uiCalendarConfig.calendars[calendar]){
	        uiCalendarConfig.calendars[calendar].fullCalendar('render');
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
		    ];
	},

	controllerAs : 'vm',

})