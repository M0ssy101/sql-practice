-- Group by user and count the rows in each group: one row = one follower.
-- DISTINCT isn't needed here: (user_id, follower_id) is the table's primary key, so the
-- same follower can't appear twice for one user. Compare 596, where duplicates were possible.
-- ORDER BY user_id ASC because the problem asks for the result sorted by user_id.

select user_id, count(follower_id) as followers_count from Followers
group by user_id
order by user_id asc
