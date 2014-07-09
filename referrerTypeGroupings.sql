
/* This query groups up the case_referrer_org_type field into 9 categories. */

select
	case
		when LEFT(case_referrer_org_type, 9) = 'Surestart'
		then 'Surestart'

		when case_referrer_org_type in 
			('Tenancy Support', 
			'Tenancy Support Services')
		then 'Tenancy Support Services'
			
		when case_referrer_org_type in 
			('Local Education Authority Services',
			'Lea Services',
			'College',
			'Community School',
			'Connexions/Careers')
		then 'Education Services'
		
		when case_referrer_org_type in
			('Probation',
			'Probation/Young Offending Service')
		then 'Probation'
		
		when case_referrer_org_type in
			('Social Services (Inc Hospital)',
			'Social Services/Childrens Trusts',
			'Other La Services E.G. Community Services',
			'Other Local Authority Services',
			'Joint Partnerships')
		then 'Social Services'

		when case_referrer_org_type in
			('Local Authority Housing',
			'Housing Associations',
			'Housing Associations / La Housing')
		then 'Housing'

		when case_referrer_org_type in
			('Health Services',
			'Community Health Services')
		then 'Health and Community Services'
		
		when case_referrer_org_type in
			('Voluntary Sector',
			'Voluntary Organisation')
		then 'Voluntary Sector'

		when case_referrer_org_type is null or
			case_referrer_org_type in
			('Individuals',
			'Joint Partnership',
			'Clergy/Churches',
			'Other')
		then 'Other'
		
		else 'UNKNOWN'
	end as ReferrerType
from
	Buttle.dbo.case_application
