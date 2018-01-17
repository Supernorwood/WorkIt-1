angular.module('appModule').component('calendar', {
	templateUrl : 'app/appModule/calendar/calendar.component.html',
	controller : function(authService, $location, jobsService) {
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

		vm.addEvent = function() {
			jobsService.getDateCreated().then(function(response) {
				vm.newEvent = response.data
			})
		}
		
		vm.addEvent();
		
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
	     /* Render Tooltip */
	    vm.eventRender = function( event, element, view ) { 
	        element.attr({'tooltip': event.title,
	                     'tooltip-append-to-body': true});
	        $compile(element)(vm.eventRender); //not sure on this one
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