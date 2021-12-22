alter session set nls_date_format = 'DD.MM.YYYY'; 

describe user_constraints;

select  uc.constraint_name, uc.constraint_type, uc.table_name, ucc.column_name, ucc.position,
        pucc.table_name as ParentTable, pucc.column_name as PartenTableColumn, pucc.position, 
        uc.delete_rule, uc.deferrable, uc.deferred, uc.status
    from    user_constraints uc, user_cons_columns ucc, user_cons_columns pucc
    where   uc.constraint_name = ucc.constraint_name and
            uc.r_constraint_name = pucc.constraint_name and
            ucc.position = pucc.position and
            uc.table_name = upper('&table') and
            uc.constraint_type in ('R');

/* test-case
create table parent(
    p1 int,
    p2 int,
    primary key (p1, p2));

create table child(
    c1 int,
    c2 int,
    foreign key (c1, c2) references parent(p1, p2));

drop table parent;
drop table child;
*/
