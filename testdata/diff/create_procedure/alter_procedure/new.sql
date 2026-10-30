CREATE PROCEDURE process_payment(
    order_id integer,
    amount numeric,
    payment_method text DEFAULT 'credit_card'
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
-- Issue #677: unchanged comment must survive the DROP + CREATE cycle
COMMENT ON PROCEDURE process_payment(integer, numeric, text) IS 'Marks an order as paid';

-- Issue #677: body-only change keeps the same signature, so pgschema plans
-- DROP + CREATE; the unchanged comment must be re-emitted afterwards.
CREATE PROCEDURE log_event(message text)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO event_log (message, logged_at) VALUES (message, NOW());
END;
$$;
COMMENT ON PROCEDURE log_event(text) IS 'Appends a message to event_log';
