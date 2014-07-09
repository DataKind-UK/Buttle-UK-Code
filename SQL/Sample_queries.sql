--Data checking

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.anontext_stage as t
;

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.case_application_stage as t
;

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.case_evaluation_stage as t
;

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.family_stage as t
;

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.financial_stage as t
;

select
count(*) as "rows",
count (distinct t.case_id) as "ids"
from sandbox.transaction_stage as t
;


CREATE TEMPORARY TABLE datechecks
AS
select 
	t.case_id,
	max(t.case_date_decided) as "max",
	min(t.case_date_decided) as "min"
from transaction_table as t
group by 1
;

select 
	sum(g.max - g.min) --should be 0
from datechecks as g;

-- creating grant summary from grant transactions

select
	g.case_id,
	min(g.case_decision_date) as "grant_decision_date",
	count( distinct g.grant_id ) as "granted_total_no_grants",
	sum(g.grant_transaction_value) as "granted_total_value",
	count(*) as "granted_no_of_transactions",	
	sum(case when g.grant_transaction_method = 'CHEQ' then g.grant_transaction_value else 0 end) as "granted_value_of_cheques",
	sum(case when g.grant_transaction_method = 'ITEM' then g.grant_transaction_value else 0 end) as "granted_value_of_items",
	sum(case when g.grant_transaction_method = 'HOLD' then g.grant_transaction_value else 0 end) as "granted_value_of_hold",
	sum(case when g.grant_transaction_method = 'STOP' then g.grant_transaction_value else 0 end) as "granted_value_of_stop",
	sum(case when g.grant_transaction_method = 'CANL' then g.grant_transaction_value else 0 end) as "granted_value_of_cancelled",	
from 
	sandbox.grant_transactions as g
group by 1
;

---basic profiling of tables

select 
	avg(g.granted_total_value),
	stddev(g.granted_total_value),
	min(g.granted_total_value),
	max(g.granted_total_value)
from grant_summary as g
;

