create or replace function "GET_LOC_LIST" (p_user_id in NUMBER)
return type_loc_list PIPELINED is 
begin
    FOR loc_rec IN (
        SELECT DISTINCT loc
        FROM item_loc_soh ils
        WHERE EXISTS (
            SELECT 1
            FROM usr_dept ud
            WHERE ud.user_id = p_user_id
              AND ud.dept = ils.dept
        )
    ) LOOP
        PIPE ROW (loc_rec.loc);
    END LOOP;
    RETURN;
end;
/