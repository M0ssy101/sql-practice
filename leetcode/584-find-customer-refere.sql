-- Simple condition based filtering
-- Avoid the Null trap, null can't be something that a value is equal to, it "IS" NULL
select name from Customer
where referee_id != 2 
    or referee_id is null;