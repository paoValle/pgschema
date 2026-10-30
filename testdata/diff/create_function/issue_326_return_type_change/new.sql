CREATE OR REPLACE FUNCTION somefunction(
    param1 text
) RETURNS integer
LANGUAGE sql
AS $$ SELECT length(param1); $$;

-- Issue #677: unchanged comment must survive the DROP + CREATE cycle
COMMENT ON FUNCTION somefunction(text) IS 'Returns text based on param1';
