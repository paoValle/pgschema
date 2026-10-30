CREATE OR REPLACE FUNCTION somefunction(
    param1 text
) RETURNS text
LANGUAGE sql
AS $$ SELECT param1; $$;

COMMENT ON FUNCTION somefunction(text) IS 'Returns text based on param1';
