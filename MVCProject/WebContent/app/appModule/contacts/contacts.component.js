angular.module('appModule')
	.component('contacts', {
		templateUrl : 'app/appModule/contacts/contacts.component.html',
		controller : function (contactsService, $filter, $routeParams, $location, $cookies) {
			var vm = this;
			
			vm.contacts = [];
			vm.selectedContact = null;
			vm.editContact = null;
			vm.newContact = null;
			vm.showAllContacts = false;
			
			vm.orderByTypes = [
				'company',
				'lastName',
				'firstName',
			];
			
			vm.sortType = 'lastName';  //default sort type
			
			var reloadContacts = function() {
				contactsService.index().then(function(response) {
					vm.contacts = response.data;
				})
				.catch(console.error)
			}
			
			reloadContacts();
			
			vm.addContact = function(contact) {
				contactsService.create(contact).then(function(response) {
					reloadContacts();
				})
				.catch(console.error)
			}
			
			vm.newXtact = function() {
				return vm.newContact = "bunnies";
			}
			
// *** MOVED functionality to setEditContact because we want to skip display and go straight to edit
// *** WHY? because all the main info is included in main table display already
			
//			vm.displayContact = function(contact) {
//				return vm.selectedContact = contact; 
//			}
			
			vm.displayAllContacts = function() {
				vm.selectedContact = null;
			}
			
			vm.updateContact = function(contact) {
				contactsService.update(contact).then(function(response) {
					reloadContacts();
					vm.selectedContact = null;
					vm.editContact = null;
				})
				.catch(console.error)
			}
			
			vm.destroyContact = function(contactId) {
				contactsService.destroy(contactId).then(function(response) {
					reloadContacts();
				})
				.catch(console.error)
			}
			
			vm.setEditContact = function(contact) {
				vm.selectedContact = contact;
				vm.editContact = angular.copy(vm.selectedContact);
			}
			
			vm.cancel = function(){
				vm.selectedContact = null;
				vm.editContact = null
			}
			
			
		},
		controllerAs : "vm"
	})