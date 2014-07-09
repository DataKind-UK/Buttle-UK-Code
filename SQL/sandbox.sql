/*
 Navicat PostgreSQL Data Transfer

 Source Server         : Local Host
 Source Server Version : 90304
 Source Host           : localhost
 Source Database       : Rishi
 Source Schema         : sandbox

 Target Server Version : 90304
 File Encoding         : utf-8

 Date: 06/06/2014 13:50:11 PM
*/

-- ----------------------------
--  Table structure for family_geography
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."family_geography";
CREATE TABLE "sandbox"."family_geography" (
	"case_id" int8 NOT NULL,
	"family_ons_output_area_id" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."family_geography" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for transaction_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."transaction_stage";
CREATE TABLE "sandbox"."transaction_stage" (
	"grant_id" int8 NOT NULL,
	"case_id" int8 NOT NULL,
	"case_decision_date" date,
	"grant_transaction_item" varchar(255) COLLATE "default",
	"grant_transaction_value" float8,
	"grant_transaction_no" int8,
	"grant_no" int8,
	"grant_transaction_method" varchar(255) COLLATE "default",
	"grant_refund_reason" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."transaction_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for family_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."family_stage";
CREATE TABLE "sandbox"."family_stage" (
	"case_id" int8 NOT NULL,
	"case_application_date" date NOT NULL,
	"family_id" float8,
	"family_member_id" int8,
	"family_member_type" varchar(255) COLLATE "default",
	"family_member_dob" date,
	"family_member_sex" varchar(255) COLLATE "default",
	"family_ethnic_group" varchar(255) COLLATE "default",
	"family_post_code_full" varchar(255) COLLATE "default",
	"family_post_code" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."family_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for case_application_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."case_application_stage";
CREATE TABLE "sandbox"."case_application_stage" (
	"case_id" int8 NOT NULL,
	"family_id" float8,
	"case_application_date" date,
	"case_referrer_id" int8,
	"case_referrer_org_id" int8,
	"case_referrer_org_type" varchar(255) COLLATE "default",
	"case_supporting_info_text" text COLLATE "default",
	"case_request_summary_text" text COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."case_application_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for case_evaluation_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."case_evaluation_stage";
CREATE TABLE "sandbox"."case_evaluation_stage" (
	"case_id" int8 NOT NULL,
	"eval_family_type" varchar(255) COLLATE "default",
	"eval_application_purpose" varchar(255) COLLATE "default",
	"eval_decision" varchar(255) COLLATE "default",
	"eval_approval_reason_main" varchar(255) COLLATE "default",
	"eval_approval_reason_2" varchar(255) COLLATE "default",
	"eval_approval_reason_3" varchar(255) COLLATE "default",
	"eval_approval_reason_4" varchar(255) COLLATE "default",
	"eval_approval_no_of_reasons" int8,
	"eval_refusal_reason_main" varchar(255) COLLATE "default",
	"eval_refusal_type" varchar(255) COLLATE "default",
	"eval_recommendation_text" text COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."case_evaluation_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for anontext_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."anontext_stage";
CREATE TABLE "sandbox"."anontext_stage" (
	"case_id" int8 NOT NULL,
	"case_request_summary_text" text COLLATE "default",
	"case_supporting_info_text" text COLLATE "default",
	"eval_recommendation_text" text COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."anontext_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for case_application
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."case_application";
CREATE TABLE "sandbox"."case_application" (
	"case_id" int8,
	"family_id" float8,
	"case_application_date" date,
	"case_referrer_id" int8,
	"case_referrer_org_id" int8,
	"case_referrer_org_type" varchar(255) COLLATE "default",
	"case_supporting_info_text" text COLLATE "default",
	"case_request_summary_text" text COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."case_application" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for financial_stage
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."financial_stage";
CREATE TABLE "sandbox"."financial_stage" (
	"case_id" int8 NOT NULL,
	"fin_wkly_income" float8,
	"fin_total_savings" float8,
	"fin_total_debt" float8,
	"fin_wkly_earnings" float8,
	"fin_wkly_income_support" float8,
	"fin_wkly_benefits_child" float8,
	"fin_wkly_benefits_incapacity" float8,
	"fin_wkly_pension" float8,
	"fin_wkly_tax_cred_child" float8,
	"fin_wkly_tax_cred_family" float8,
	"fin_wkly_allow_job" float8,
	"fin_wkly_allow_employment" float8,
	"fin_wkly_allow_employ_with_contribribution" float8,
	"fin_wkly_allow_training" float8,
	"fin_wkly_allow_education" float8,
	"fin_wkly_allow_disability_care_child" float8,
	"fin_wkly_allow_disability_care_parent" float8,
	"fin_wkly_allow_disability_mobility_child" float8,
	"fin_wkly_allow_disability_mobility_parent" float8,
	"fin_grant_community_care" float8,
	"fin_wkly_grant_student_loan" float8,
	"fin_loan_amount_outstanding" float8,
	"fin_loan_amount_total" float8,
	"fin_wkly_other_income_1" float8,
	"fin_wkly_other_income_2" float8,
	"fin_desc_other_income_1" varchar(255) COLLATE "default",
	"fin_desc_other_income_2" varchar(255) COLLATE "default",
	"fin_total_savings_yn" bool,
	"fin_total_debt_yn" bool,
	"fin_support_other_charity_yn" bool,
	"fin_loan_social_fund_yn" bool,
	"fin_grant_comm_care_yn" bool,
	"fin_grant_comm_care_awaiting_yn" bool,
	"fin_grant_comm_care_refused_yn" bool,
	"fin_grant_comm_care_appealed_yn" bool,
	"fin_grant_comm_care_date_awarded" date,
	"fin_grant_comm_care_date_submitted" date,
	"fin_loan_social_fund_date_awarded" date
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."financial_stage" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for family_details
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."family_details";
CREATE TABLE "sandbox"."family_details" (
	"case_id" int8,
	"case_application_date" date,
	"family_id" float8,
	"family_ethnic_group" varchar(255) COLLATE "default",
	"family_member_id" int8,
	"family_member_type" varchar(255) COLLATE "default",
	"family_member_type_category" text COLLATE "default",
	"family_member_dob" date,
	"family_member_age" int4,
	"family_post_code_full" varchar(255) COLLATE "default",
	"family_post_code" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."family_details" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for family_attribute
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."family_attribute";
CREATE TABLE "sandbox"."family_attribute" (
	"case_id" int8,
	"family_id" float8,
	"family_ethnic_group" varchar(255) COLLATE "default",
	"family_type" text COLLATE "default",
	"family_no_of_members" int8,
	"family_no_of_parent_guardian" int8,
	"family_no_of_young_persons" int8,
	"family_no_of_grand_parents" int8,
	"family_no_of_adults" int8,
	"family_no_of_children" int8,
	"family_no_of_children_0_to_2" int8,
	"family_age_of_youngest_member" int4,
	"family_age_of_eldest_member" int4
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."family_attribute" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for family_financials
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."family_financials";
CREATE TABLE "sandbox"."family_financials" (
	"case_id" int8,
	"fin_wkly_income" float8,
	"fin_total_savings" float8,
	"fin_total_debt" float8,
	"fin_wkly_earnings" float8,
	"fin_wkly_income_support" float8,
	"fin_wkly_benefits_child" float8,
	"fin_wkly_benefits_incapacity" float8,
	"fin_wkly_pension" float8,
	"fin_wkly_tax_cred_child" float8,
	"fin_wkly_tax_cred_family" float8,
	"fin_wkly_allow_job" float8,
	"fin_wkly_allow_employment" float8,
	"fin_wkly_allow_employ_with_contribribution" float8,
	"fin_wkly_allow_training" float8,
	"fin_wkly_allow_education" float8,
	"fin_wkly_allow_disability_care_child" float8,
	"fin_wkly_allow_disability_care_parent" float8,
	"fin_wkly_allow_disability_mobility_child" float8,
	"fin_wkly_allow_disability_mobility_parent" float8,
	"fin_grant_community_care" float8,
	"fin_wkly_grant_student_loan" float8,
	"fin_loan_amount_outstanding" float8,
	"fin_loan_amount_total" float8,
	"fin_wkly_other_income_1" float8,
	"fin_wkly_other_income_2" float8,
	"fin_desc_other_income_1" varchar(255) COLLATE "default",
	"fin_desc_other_income_2" varchar(255) COLLATE "default",
	"fin_total_savings_yn" bool,
	"fin_total_debt_yn" bool,
	"fin_support_other_charity_yn" bool,
	"fin_loan_social_fund_yn" bool,
	"fin_grant_comm_care_yn" bool,
	"fin_grant_comm_care_awaiting_yn" bool,
	"fin_grant_comm_care_refused_yn" bool,
	"fin_grant_comm_care_appealed_yn" bool,
	"fin_grant_comm_care_date_awarded" date,
	"fin_grant_comm_care_date_submitted" date,
	"fin_loan_social_fund_date_awarded" date
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."family_financials" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for case_evaluation
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."case_evaluation";
CREATE TABLE "sandbox"."case_evaluation" (
	"case_id" int8,
	"eval_family_type" varchar(255) COLLATE "default",
	"eval_application_purpose" varchar(255) COLLATE "default",
	"eval_decision" varchar(255) COLLATE "default",
	"eval_approval_reason_main" varchar(255) COLLATE "default",
	"eval_approval_reason_2" varchar(255) COLLATE "default",
	"eval_approval_reason_3" varchar(255) COLLATE "default",
	"eval_approval_reason_4" varchar(255) COLLATE "default",
	"eval_approval_no_of_reasons" int8,
	"eval_refusal_reason_main" varchar(255) COLLATE "default",
	"eval_refusal_type" varchar(255) COLLATE "default",
	"eval_recommendation_text" text COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."case_evaluation" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for grant_transactions
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."grant_transactions";
CREATE TABLE "sandbox"."grant_transactions" (
	"grant_id" int8,
	"case_id" int8,
	"case_decision_date" date,
	"grant_no_in_case" int8,
	"grant_transaction_method" varchar(255) COLLATE "default",
	"grant_transaction_item" varchar(255) COLLATE "default",
	"grant_transaction_value" float8,
	"grant_transaction_no" int8,
	"grant_refund_reason" varchar(255) COLLATE "default"
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."grant_transactions" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for grant_summary
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."grant_summary";
CREATE TABLE "sandbox"."grant_summary" (
	"case_id" int8,
	"grant_decision_date" date,
	"granted_total_no_of_grants" int8,
	"granted_total_value" float8,
	"granted_no_of_transactions" int8,
	"granted_value_of_cheques" float8,
	"granted_value_of_items" float8,
	"granted_value_of_hold" float8,
	"granted_value_of_stop" float8,
	"granted_value_of_cancelled" float8
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."grant_summary" OWNER TO "Rishi";

-- ----------------------------
--  Table structure for buttle_uk_ads
-- ----------------------------
DROP TABLE IF EXISTS "sandbox"."buttle_uk_ads";
CREATE TABLE "sandbox"."buttle_uk_ads" (
	"case_id" int8,
	"family_id" float8,
	"family_ethnic_group" varchar(255) COLLATE "default",
	"family_type" text COLLATE "default",
	"family_no_of_members" int8,
	"family_no_of_parent_guardian" int8,
	"family_no_of_young_persons" int8,
	"family_no_of_grand_parents" int8,
	"family_no_of_adults" int8,
	"family_no_of_children" int8,
	"family_no_of_children_0_to_2" int8,
	"family_age_of_youngest_member" int4,
	"family_age_of_eldest_member" int4,
	"family_ons_output_area_id" varchar(255) COLLATE "default",
	"fin_wkly_income" float8,
	"fin_total_savings" float8,
	"fin_total_debt" float8,
	"fin_wkly_earnings" float8,
	"fin_wkly_income_support" float8,
	"fin_wkly_benefits_child" float8,
	"fin_wkly_benefits_incapacity" float8,
	"fin_wkly_pension" float8,
	"fin_wkly_tax_cred_child" float8,
	"fin_wkly_tax_cred_family" float8,
	"fin_wkly_allow_job" float8,
	"fin_wkly_allow_employment" float8,
	"fin_wkly_allow_employ_with_contribribution" float8,
	"fin_wkly_allow_training" float8,
	"fin_wkly_allow_education" float8,
	"fin_wkly_allow_disability_care_child" float8,
	"fin_wkly_allow_disability_care_parent" float8,
	"fin_wkly_allow_disability_mobility_child" float8,
	"fin_wkly_allow_disability_mobility_parent" float8,
	"fin_grant_community_care" float8,
	"fin_wkly_grant_student_loan" float8,
	"fin_loan_amount_outstanding" float8,
	"fin_loan_amount_total" float8,
	"fin_wkly_other_income_1" float8,
	"fin_wkly_other_income_2" float8,
	"fin_desc_other_income_1" varchar(255) COLLATE "default",
	"fin_desc_other_income_2" varchar(255) COLLATE "default",
	"fin_total_savings_yn" bool,
	"fin_total_debt_yn" bool,
	"fin_support_other_charity_yn" bool,
	"fin_loan_social_fund_yn" bool,
	"fin_grant_comm_care_yn" bool,
	"fin_grant_comm_care_awaiting_yn" bool,
	"fin_grant_comm_care_refused_yn" bool,
	"fin_grant_comm_care_appealed_yn" bool,
	"fin_grant_comm_care_date_awarded" date,
	"fin_grant_comm_care_date_submitted" date,
	"fin_loan_social_fund_date_awarded" date,
	"case_application_date" date,
	"case_referrer_id" int8,
	"case_referrer_org_id" int8,
	"case_referrer_org_type" varchar(255) COLLATE "default",
	"case_supporting_info_text" text COLLATE "default",
	"case_request_summary_text" text COLLATE "default",
	"eval_family_type" varchar(255) COLLATE "default",
	"eval_application_purpose" varchar(255) COLLATE "default",
	"eval_decision" varchar(255) COLLATE "default",
	"eval_approval_reason_main" varchar(255) COLLATE "default",
	"eval_approval_reason_2" varchar(255) COLLATE "default",
	"eval_approval_reason_3" varchar(255) COLLATE "default",
	"eval_approval_reason_4" varchar(255) COLLATE "default",
	"eval_approval_no_of_reasons" int8,
	"eval_refusal_reason_main" varchar(255) COLLATE "default",
	"eval_refusal_type" varchar(255) COLLATE "default",
	"eval_recommendation_text" text COLLATE "default",
	"grant_decision_date" date,
	"granted_total_no_of_grants" int8,
	"granted_total_value" float8,
	"granted_no_of_transactions" int8,
	"granted_value_of_cheques" float8,
	"granted_value_of_items" float8,
	"granted_value_of_hold" float8,
	"granted_value_of_stop" float8,
	"granted_value_of_cancelled" float8
)
WITH (OIDS=FALSE);
ALTER TABLE "sandbox"."buttle_uk_ads" OWNER TO "Rishi";

