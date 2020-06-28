version=2

rule=rule1: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]  Id: %query_id:number%%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:char-to:;%;%-:char-to:T%Time: %query_clock:rest%
rule=rule2: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]  Id: %query_id:number%%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:char-to:;%;
rule=rule3: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]  Id: %query_id:number%%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:rest%

rule=rule4: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]  Id: %query_id:number%%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nuse %use_db:char-to:;%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:char-to:;%%-:char-to:T%Time: %time_rest:rest%
rule=rule5: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]  Id: %query_id:number%%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nuse %use_db:char-to:;%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:rest%

rule=rule6: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nuse %use_db:char-to:;%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:rest%
rule=rule7: # User@Host: %mysql_user:word% @  [%mysql_client:char-to:]%]%-:char-to:n%n# Query_time: %query_time:float%  Lock_time: %lock_time:float% Rows_sent: %rows_sent:number%  Rows_examined: %rows_examined:number%%-:char-to:n%nSET timestamp=%timestamp:number%%-:char-to:n%n%query_sql:rest%

rule=rule8: # Time: %errmsg:rest%
rule=rule-rest:%errmsg:rest%
