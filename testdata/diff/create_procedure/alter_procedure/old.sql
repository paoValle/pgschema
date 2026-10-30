CREATE PROCEDURE process_payment(
    order_id integer,
    amount numeric
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders 
    SET status = 'paid', payment_amount = amount 
    WHERE id = order_id;
    
    COMMIT;
END;
$$;
COMMENT ON PROCEDURE process_payment(integer, numeric) IS 'Marks an order as paid';

-- Issue #677: body-only change keeps the same signature, so pgschema plans
-- DROP + CREATE; the unchanged comment must be re-emitted afterwards.
CREATE PROCEDURE log_event(message text)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO event_log (message) VALUES (message);
END;
$$;
COMMENT ON PROCEDURE log_event(text) IS 'Appends a message to event_log';
