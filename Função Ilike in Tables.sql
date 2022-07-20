CREATE OR REPLACE FUNCTION PUBLIC.fn_ilike_in_tables (VALOR VARCHAR, SCHEMA VARCHAR) 
  RETURNS TABLE (
      coluna VARCHAR,
      tabela VARCHAR
  ) AS 
$$
DECLARE
    rQUERY_RESULT RECORD;
    vCMD VARCHAR;
BEGIN
    vCMD := '';
    
    FOR rQUERY_RESULT IN (
    
         SELECT X.TABLE_NAME,
                X.COLUMN_NAME, TABLE_SCHEMA
           FROM INFORMATION_SCHEMA.COLUMNS X
          WHERE X.TABLE_SCHEMA = SCHEMA
            AND UPPER(X.DATA_TYPE) IN  ('CHARACTER VARYING','TEXT')
            AND X.IS_UPDATABLE = 'YES'
 
    ) LOOP
    
         vCMD := vCMD ||  
                 ' SELECT '|| rQUERY_RESULT.COLUMN_NAME ||'::VARCHAR AS COLUNA, ' || '''' || rQUERY_RESULT.TABLE_NAME || '''' || '::VARCHAR AS TABELA ' || 
                   ' FROM '|| SCHEMA||'.'|| rQUERY_RESULT.TABLE_NAME || 
                  ' WHERE '|| rQUERY_RESULT.COLUMN_NAME || '::VARCHAR ILIKE ' || '''' || VALOR || '''' || 
                  ' UNION SELECT NULL, NULL'; 
               
    END LOOP;
 
    RETURN QUERY EXECUTE vCMD;   
END $$ 
LANGUAGE 'plpgsql' 
  CALLED ON NULL INPUT;