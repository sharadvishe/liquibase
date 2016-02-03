CREATE OR REPLACE FUNCTION "etl"."handle_exception" (
  errormessage text,
  childfunction text
)
RETURNS boolean VOLATILE
AS $$
DECLARE ErrorText text := '';
BEGIN

  ErrorText := 'Execution of "' || childfunction
    || '" terminated,reporting the exception "' || errormessage || '"';

  RAISE NOTICE '%', ErrorText;

  RAISE EXCEPTION USING 
    MESSAGE := ErrorText,
    HINT := 'Error raised in function - ' || childfunction;

END;
$$ LANGUAGE plpgsql
