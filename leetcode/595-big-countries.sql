-- Key word to pass the test is "Least", use the correct operator in the constraint
Select name, population, area from World
where area >= 3000000 or population >= 25000000;