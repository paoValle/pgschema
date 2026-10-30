DROP FUNCTION IF EXISTS somefunction(text);

CREATE OR REPLACE FUNCTION somefunction(
    param1 text
)
RETURNS integer
LANGUAGE sql
VOLATILE
AS $$ SELECT length(param1);
$$;

COMMENT ON FUNCTION somefunction(text) IS 'Returns text based on param1';
