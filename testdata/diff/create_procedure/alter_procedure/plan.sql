DROP PROCEDURE IF EXISTS process_payment(IN order_id integer, IN amount numeric);

CREATE OR REPLACE PROCEDURE process_payment(
    IN order_id integer,
    IN amount numeric,
    IN payment_method text DEFAULT 'credit_card'
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders 
    SET status = 'paid', 
        payment_amount = amount,
        payment_method = payment_method,
        processed_at = NOW()
    WHERE id = order_id;
    
    INSERT INTO payment_history (order_id, amount, method, processed_at)
    VALUES (order_id, amount, payment_method, NOW());
    
    COMMIT;
END;
$$;

COMMENT ON PROCEDURE process_payment(integer, numeric, text) IS 'Marks an order as paid';

DROP PROCEDURE IF EXISTS log_event(IN message text);

CREATE OR REPLACE PROCEDURE log_event(
    IN message text
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO event_log (message, logged_at) VALUES (message, NOW());
END;
$$;

COMMENT ON PROCEDURE log_event(text) IS 'Appends a message to event_log';
