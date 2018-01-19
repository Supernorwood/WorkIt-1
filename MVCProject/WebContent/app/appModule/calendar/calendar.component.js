angular.module('appModule').component('calendar', {
	templateUrl : 'app/appModule/calendar/calendar.component.html',
	controller : function(authService, $location, jobsService, uiCalendarConfig) {
		var vm = this;
		
		vm.selected = null; //this will be useful for the click event on the calendar itself
		
		
		//Below is CRUD functionality for events. -RU
		vm.events = [];

		vm.newEvent = null;
		
		var reloadEvents = function() {
			jobsService.getEvents()
			.then(function(response){
				vm.events = response.data
			})
			.catch(console.error)
		}
		
		reloadEvents();
		
		vm.addEvent = function(event){
			jobsService.create(event)
			.then(function(response){
				reloadEvents();
				
			})
			.catch(console.error)
		}
		
		vm.displayEvent = function(event){
			return vm.selected = event;
		}
		
		vm.displayAllEvents = function() {
			vm.selected = null;
		}
		
		vm.updateEvent = function(editedEvent) {
			jobsService.updateEvent(editedEvent)
			.then(function(response){
				reloadEvents();
			})
		}
		
		vm.destroyEvent = function(id) {
			jobsService.destroy(id)
			.then(function(response){
				reloadEvents();
			})
			.catch(console.error)
		}
		
		
		//Below is calendar-specific functions. Notes show what it does, but I'm still mostly baffled -RU
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
		//^^This works and displays the calendar -RU
		
		
		//The below were copied from the Angular UI calendar page and appear to not be working -RU
		//It will be necessary to find a way to get them to integrate with the CRUD functionality -RU
		
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
	        title: '',
	        start: new Date(y, m, d),
	        end: new Date(y, m, d),
//	        className: ['openSesame']
	      });
	    };
	    
	    /* need to add edit functionality as well*/
	    
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
		      {title: '5',start: new Date(y, m, d)},
		      {title: 'Long Event',start: new Date(y, m, d - 5),end: new Date(y, m, d - 2)},
		      {id: 999,title: 'Repeating Event',start: new Date(y, m, d - 3, 16, 0),allDay: false},
		      {id: 999,title: 'Repeating Event',start: new Date(y, m, d + 4, 16, 0),allDay: false},
		    ];
		
	    vm.eventSources = [vm.events];
	    //need the data to be formatted exactly like this -- convert from UTC
	    //The data is formatted y-m-d in the database, so this might work unless it converts it when it's pulled out -RU
	},

	controllerAs : 'vm',

})