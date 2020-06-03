﻿Feature: Flow
	As a user of Dnipro store
	I want to be able to create account and make an order

Background:
	Given I create user in store
		| Name           | Age | Email                  | Address |
		| Lord Voldemort | 45  | avadakedavra@gmail.com | London  |
	And I add 'Pandemia' book to store

Scenario: Easy positive flow
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order present in store
	#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store

Scenario: Delete user before process order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I delete Lord Voldemort user
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absent in store
	#clean up
	When I delete 'Pandemia' book from store

Scenario: Delete book before process order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from store
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absent in store
	#clean up
	When I delete Lord Voldemort user

Scenario: Order more books then available in store
	When I add 'Pandemia' book to Lord Voldemort user cart 6 times
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absent in store
	#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store

Scenario: Delete from store one of two book in cart
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I add 'World War' book to store
	And I add 'World War' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from store
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order absent in store
	#clean up
	When I delete Lord Voldemort user
	And I delete 'Pandemia' book from store

Scenario: Check absence of deleted book from cart in order
	When I add 'Pandemia' book to Lord Voldemort user cart
	And I add 'World War' book to store
	And I add 'World War' book to Lord Voldemort user cart
	And I delete 'Pandemia' book from Lord Voldemort user cart
	And I place order from Lord Voldemort user cart
	Then I check Lord Voldemort user order present in store
	And Lord Voldemort user order contain books
		| Books     |
		| World War |
	#clean up
	When I delete Lord Voldemort user
	And I delete 'World War' book from store
	And I delete 'Pandemia' book from store

Scenario Outline: Two users try to buy all and more then available books
	And I create user in store
		| Name       | Age | Email                   | Address    |
		| Tom Riddle | 17  | SlytherinHeir@gmail.com | SecretRoom |
	When I add 'Pandemia' book to Lord Voldemort user cart 3 times
	And I add 'Pandemia' book to Tom Riddle user cart <Quantity> times
	And I place order from Lord Voldemort user cart
	And I place order from Tom Riddle user cart
	Then I check Lord Voldemort user order present in store
	And I check Tom Riddle user order <Presence> in store
	#clean up
	When I delete Lord Voldemort user
	And I delete Tom Riddle user
	And I delete 'Pandemia' book from store

	Examples:
		| Quantity | Presence |
		| 2        | present  |
		| 5        | absent   |