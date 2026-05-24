WITH RECURSIVE chain AS (

    -- PART 1: ANCHOR (runs once)
    SELECT 
        giver_id         AS start_id,
        giver_id         AS current_giver,
        receiver_id      AS current_receiver,
        gift_value       AS total_value,
        1                AS chain_length
    FROM SecretSanta

    UNION ALL

    -- PART 2: RECURSIVE (runs again and again)
    SELECT
        c.start_id,
        c.current_receiver          AS current_giver,
        s.receiver_id               AS current_receiver,
        c.total_value + s.gift_value AS total_value,
        c.chain_length + 1          AS chain_length
    FROM chain c
    JOIN SecretSanta s 
        ON s.giver_id = c.current_receiver
    WHERE c.current_receiver <> c.start_id

),

-- PART 3: Keep only completed cycles
completed_cycles AS (
    SELECT 
        start_id, 
        chain_length, 
        total_value
    FROM chain
    WHERE current_receiver = start_id
),

-- PART 4: Remove duplicate cycles
deduplicated AS (
    SELECT
        ROW_NUMBER() OVER (
            ORDER BY chain_length DESC, total_value DESC
        )                    AS chain_id,
        chain_length,
        total_value          AS total_gift_value
    FROM completed_cycles c1
    WHERE start_id = (
        SELECT MIN(c2.start_id)
        FROM completed_cycles c2
        WHERE c2.chain_length = c1.chain_length
          AND c2.total_value  = c1.total_value
    )
)

-- PART 5: Final result
SELECT 
    chain_id, 
    chain_length, 
    total_gift_value
FROM deduplicated
ORDER BY chain_length DESC, total_gift_value DESC;