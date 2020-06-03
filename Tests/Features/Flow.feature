﻿Feature: Flow
	As a user of Dnipro store
	I want to be able to create account and make an order

Background: 
	Given I create user in store
		| Name           | Age | Email                  | Address |
		| Lord Voldemort | 45  | avadakedavra@gmail.com | London  |
	And I add 'Pandemia' book to store

Scenario: Usual positive flow
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order presence in store
#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store

Scenario: Delete user before process order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I delete Lord Voldemort user
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absence in store
#clean up
	When I delete 'Pandemia' book from store

Scenario: Delete book before process order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from store
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absence in store
#clean up
	When I delete Lord Voldemort user

Scenario: Order more books then available in store
	When I add 'Pandemia' book to Lord Voldemort user cart 6 times
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absence in store
#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store

Scenario: Delete from store one of two book in cart
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I add 'World War' book to store
	And I add 'World War' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from store
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absence in store
#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store
	#--
Scenario: Check absence of deleted book from cart in order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I add 'World War' book to store
	And I add 'World War' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from Lord Voldemort user cart
	And I create order from Lord Voldemort user cart
	Then I check Lord Voldemort user order presence in store
	And Lord Voldemort user order contain books
	| Books     |
	| World War |
#clean up
	When I delete Lord Voldemort user
	And I delete 'World War' book from store
	And I delete 'Pandemia' book from store

#using two users try to buy more then available