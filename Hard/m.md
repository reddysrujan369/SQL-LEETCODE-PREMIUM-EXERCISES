
Description
Table: SecretSanta

+-------------+------+
| Column Name | Type |
+-------------+------+
| giver_id    | int  |
| receiver_id | int  |
| gift_value  | int  |
+-------------+------+
(giver_id, receiver_id) is the unique key for this table.   
Each row represents a record of a gift exchange between two employees, giver_id represents the employee who gives a gift, receiver_id represents the employee who receives the gift and gift_value represents the value of the gift given.  
Write a solution to find the total gift value and length of circular chains of Secret Santa gift exchanges:

A circular chain is defined as a series of exchanges where:

Each employee gives a gift to exactly one other employee.
Each employee receives a gift from exactly one other employee.
The exchanges form a continuous loop (e.g., employee A gives a gift to B, B gives to C, and C gives back to A).
Return the result ordered by the chain length and total gift value of the chain in descending order. 

The result format is in the following example.

 

Example:

Input:

SecretSanta table:

+----------+-------------+------------+
| giver_id | receiver_id | gift_value |
+----------+-------------+------------+
| 1        | 2           | 20         |
| 2        | 3           | 30         |
| 3        | 1           | 40         |
| 4        | 5           | 25         |
| 5        | 4           | 35         |
+----------+-------------+------------+
Output:

+----------+--------------+------------------+
| chain_id | chain_length | total_gift_value |
+----------+--------------+------------------+
| 1        | 3            | 90               |
| 2        | 2            | 60               |
+----------+--------------+------------------+
