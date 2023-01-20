CREATE OR REPLACE FUNCTION PUBLIC.LIKE_IN_TABLES (VALOR VARCHAR, SCH VARCHAR 
 )
 RETURNS TABLE
 (
 COLUNA VARCHAR,
 TABELA VARCHAR
 ) AS
 $BODY$
 DECLARE
    TEMPROW RECORD;
    CMD VARCHAR;
 BEGIN
    CMD := '';
 
    FOR TEMPROW IN (
    
        SELECT X.TABLE_NAME,
               X.COLUMN_NAME
          FROM INFORMATION_SCHEMA.COLUMNS X
         WHERE X.TABLE_SCHEMA = $2
           AND X.IS_UPDATABLE = 'YES'
               
    ) LOOP
         
         CMD := CMD ||  ' SELECT '|| TEMPROW.COLUMN_NAME ||'::VARCHAR AS COLUNA, '|| '''' || TEMPROW.TABLE_NAME|| '''' ||'::VARCHAR AS TABELA ' || 
                          ' FROM '||SCH||'.'|| TEMPROW.TABLE_NAME || 
                         ' WHERE '|| TEMPROW.COLUMN_NAME || '::VARCHAR ILIKE ' || '''' || $1 || '''' || 
                         ' UNION '; 
    
    END LOOP;
         CMD := CMD || ' SELECT NULL, NULL ';
 
    RETURN QUERY EXECUTE CMD;   
 END;
 $BODY$
 LANGUAGE 'plpgsql'
 CALLED ON NULL INPUT; 
