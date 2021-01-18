/* Test Integrity.
Test for success.
Test for failure. */

--delete customer that has an order
--should fail

delete customers where custnum = 9989; -- vLearners Inc.

--delete book that is being sold
--should fail

delete titles where partnum = 40712; -- Recipes From India

--Create order for non existing Customer # 123
--should fail

insert sales
(ordnum,sldate,qty,custnum,partnum,repid)
values
('99','2007-08-01',300,123,40712,'W02');

--Create order for non existing Book # 100
--should fail

insert sales
(ordnum,sldate,qty,custnum,partnum,repid)
values
('99','2007-08-01',300,9989,100,'W02');

--Create order for good customer and book
--should succeed

insert sales
(ordnum,sldate,qty,custnum,partnum,repid)
values
('99','2007-08-01',300,9989,40712,'W02');

--Create duplicate Order
--should fail
--edit order number so that it succeeds
--should succeed
