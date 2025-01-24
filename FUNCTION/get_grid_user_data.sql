create or replace function "GET_GRID_USER_DATA" (p_user_id in  NUMBER)
return  SYS_REFCURSOR
as
cur_user SYS_REFCURSOR;
begin
   OPEN cur_user FOR
    SELECT 
        il.item,
        il.loc,
        il.dept,
        il.unit_cost,
        il.stock_on_hand,
        il.unit_cost * il.stock_on_hand AS stock_value
    FROM 
        item_loc_soh il
    WHERE 
        EXISTS (
            SELECT 1
            FROM usr_dept ud
            WHERE ud.user_id = p_user_id
              AND ud.dept = il.dept
        );
    RETURN cur_user;
end "GET_GRID_USER_DATA";
/