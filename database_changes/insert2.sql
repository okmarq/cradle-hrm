-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 01, 2023 at 11:31 AM
-- Server version: 5.7.34
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `orangehrm`
--

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_report_group`
--

INSERT INTO `ohrm_report_group` (`report_group_id`, `name`, `core_sql`) VALUES
(1, 'timesheet', 'SELECT selectCondition FROM ohrm_project_activity LEFT JOIN (SELECT * FROM ohrm_timesheet_item WHERE whereCondition1) AS ohrm_timesheet_item  ON (ohrm_timesheet_item.activity_id = ohrm_project_activity.activity_id) LEFT JOIN ohrm_project ON (ohrm_project.project_id = ohrm_project_activity.project_id) LEFT JOIN hs_hr_employee ON (hs_hr_employee.emp_number = ohrm_timesheet_item.employee_id) LEFT JOIN ohrm_timesheet ON (ohrm_timesheet.timesheet_id = ohrm_timesheet_item.timesheet_id) LEFT JOIN ohrm_customer ON (ohrm_customer.customer_id = ohrm_project.customer_id) WHERE whereCondition2 groupByClause ORDER BY ohrm_customer.name, ohrm_project.name, ohrm_project_activity.name, hs_hr_employee.emp_lastname, hs_hr_employee.emp_firstname'),
(2, 'attendance', 'SELECT selectCondition FROM hs_hr_employee LEFT JOIN (SELECT * FROM ohrm_attendance_record WHERE ( ( ohrm_attendance_record.punch_in_user_time BETWEEN \"#@fromDate@,@1970-01-01@#\" AND #@\"toDate\"@,@CURDATE()@# ) AND ( ohrm_attendance_record.punch_out_user_time BETWEEN \"#@fromDate@,@1970-01-01@#\" AND #@\"toDate\"@,@CURDATE()@# ) ) ) AS ohrm_attendance_record ON (hs_hr_employee.emp_number = ohrm_attendance_record.employee_id) WHERE hs_hr_employee.emp_number = #@employeeId@,@hs_hr_employee.emp_number AND (hs_hr_employee.termination_id is null) @# AND (hs_hr_employee.job_title_code = #@\"jobTitle\")@,@hs_hr_employee.job_title_code OR hs_hr_employee.job_title_code is null)@# AND (hs_hr_employee.work_station IN (#@subUnit)@,@SELECT id FROM ohrm_subunit) OR hs_hr_employee.work_station is null@#) AND (hs_hr_employee.emp_status = #@\"employeeStatus\")@,@hs_hr_employee.emp_status OR hs_hr_employee.emp_status is null)@# groupByClause ORDER BY hs_hr_employee.emp_lastname, hs_hr_employee.emp_firstname'),
(3, 'pim', 'SELECT selectCondition FROM hs_hr_employee \n                    LEFT JOIN hs_hr_emp_emergency_contacts ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_emergency_contacts.emp_number) \n                    LEFT JOIN ohrm_subunit ON \n                        (hs_hr_employee.work_station = ohrm_subunit.id) \n                    LEFT JOIN ohrm_employment_status ON \n                        (hs_hr_employee.emp_status = ohrm_employment_status.id) \n                    LEFT JOIN ohrm_job_title ON\n                        (hs_hr_employee.job_title_code = ohrm_job_title.id)\n                    LEFT JOIN ohrm_job_category ON \n                        (hs_hr_employee.eeo_cat_code = ohrm_job_category.id) \n                    LEFT JOIN ohrm_nationality ON\n                        (hs_hr_employee.nation_code = ohrm_nationality.id)\n                    LEFT JOIN hs_hr_emp_dependents ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_dependents.emp_number)\n                    LEFT JOIN hs_hr_emp_locations AS emp_location ON\n                        (hs_hr_employee.emp_number = emp_location.emp_number)\n                    LEFT JOIN ohrm_location ON\n                        (emp_location.location_id = ohrm_location.id)\n                    LEFT JOIN hs_hr_emp_contract_extend ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_contract_extend.emp_number) \n                    LEFT JOIN hs_hr_emp_basicsalary ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_basicsalary.emp_number) \n                    LEFT JOIN ohrm_pay_grade ON \n                        (hs_hr_emp_basicsalary.sal_grd_code = ohrm_pay_grade.id) \n                    LEFT JOIN hs_hr_currency_type ON \n                        (hs_hr_emp_basicsalary.currency_id = hs_hr_currency_type.currency_id) \n                    LEFT JOIN hs_hr_payperiod ON \n                        (hs_hr_emp_basicsalary.payperiod_code = hs_hr_payperiod.payperiod_code) \n                    LEFT JOIN hs_hr_emp_passport ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_passport.emp_number) \n                    LEFT JOIN hs_hr_emp_reportto AS subordinate_list ON \n                        (hs_hr_employee.emp_number = subordinate_list.erep_sup_emp_number) \n                    LEFT JOIN hs_hr_employee AS subordinate ON\n                        (subordinate.emp_number = subordinate_list.erep_sub_emp_number)\n                    LEFT JOIN ohrm_emp_reporting_method AS subordinate_reporting_method ON \n                        (subordinate_list.erep_reporting_mode = subordinate_reporting_method.reporting_method_id) \n                    LEFT JOIN hs_hr_emp_work_experience ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_work_experience.emp_number) \n                    LEFT JOIN ohrm_emp_education ON \n                        (hs_hr_employee.emp_number = ohrm_emp_education.emp_number) \n                    LEFT JOIN ohrm_education ON \n                        (ohrm_emp_education.education_id = ohrm_education.id) \n                    LEFT JOIN hs_hr_emp_skill ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_skill.emp_number) \n                    LEFT JOIN ohrm_skill ON \n                        (hs_hr_emp_skill.skill_id = ohrm_skill.id) \n                    LEFT JOIN hs_hr_emp_language ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_language.emp_number) \n                    LEFT JOIN ohrm_language ON \n                        (hs_hr_emp_language.lang_id = ohrm_language.id) \n                    LEFT JOIN ohrm_emp_license ON \n                        (hs_hr_employee.emp_number = ohrm_emp_license.emp_number) \n                    LEFT JOIN ohrm_license ON \n                        (ohrm_emp_license.license_id = ohrm_license.id) \n                    LEFT JOIN hs_hr_emp_member_detail ON \n                        (hs_hr_employee.emp_number = hs_hr_emp_member_detail.emp_number) \n                    LEFT JOIN ohrm_membership ON\n                        (hs_hr_emp_member_detail.membship_code = ohrm_membership.id)\n                    LEFT JOIN hs_hr_country ON \n                        (hs_hr_employee.coun_code = hs_hr_country.cou_code) \n                    LEFT JOIN hs_hr_emp_directdebit ON \n                        (hs_hr_emp_basicsalary.id = hs_hr_emp_directdebit.salary_id) \n                    LEFT JOIN hs_hr_emp_reportto AS supervisor_list ON \n                        (hs_hr_employee.emp_number = supervisor_list.erep_sub_emp_number) \n                    LEFT JOIN hs_hr_employee AS supervisor ON\n                        (supervisor.emp_number = supervisor_list.erep_sup_emp_number)\n                    LEFT JOIN ohrm_emp_reporting_method AS supervisor_reporting_method ON \n                        (supervisor_list.erep_reporting_mode = supervisor_reporting_method.reporting_method_id) \n                    LEFT JOIN ohrm_emp_termination ON\n                        (hs_hr_employee.termination_id = ohrm_emp_termination.id)\n                    LEFT JOIN ohrm_emp_termination_reason ON\n                        (ohrm_emp_termination.reason_id = ohrm_emp_termination_reason.id)\n                WHERE hs_hr_employee.emp_number in (\n                    SELECT hs_hr_employee.emp_number FROM hs_hr_employee\n                        LEFT JOIN hs_hr_emp_basicsalary ON \n                            (hs_hr_employee.emp_number = hs_hr_emp_basicsalary.emp_number) \n                        LEFT JOIN ohrm_emp_education ON \n                            (hs_hr_employee.emp_number = ohrm_emp_education.emp_number) \n                        LEFT JOIN hs_hr_emp_skill ON \n                            (hs_hr_employee.emp_number = hs_hr_emp_skill.emp_number) \n                        LEFT JOIN hs_hr_emp_language ON \n                            (hs_hr_employee.emp_number = hs_hr_emp_language.emp_number) \n                    WHERE whereCondition1\n                )\n                GROUP BY \n                     hs_hr_employee.emp_number,\n                     hs_hr_employee.emp_lastname,\n                     hs_hr_employee.emp_firstname,\n                     hs_hr_employee.emp_middle_name,\n                     hs_hr_employee.emp_birthday,\n                     ohrm_nationality.name,\n                     hs_hr_employee.emp_gender,\n                     hs_hr_employee.emp_marital_status,\n                     hs_hr_employee.emp_dri_lice_num,\n                     hs_hr_employee.emp_dri_lice_exp_date,\n                     hs_hr_employee.emp_street1,\n                     hs_hr_employee.emp_street2,\n                     hs_hr_employee.city_code,\n                     hs_hr_employee.provin_code,\n                     hs_hr_employee.emp_zipcode,\n                     hs_hr_country.cou_code,\n                     hs_hr_employee.emp_hm_telephone,\n                     hs_hr_employee.emp_mobile,\n                     hs_hr_employee.emp_work_telephone,\n                     hs_hr_employee.emp_work_email,\n                     hs_hr_employee.emp_oth_email\n\nORDER BY hs_hr_employee.emp_lastname\n');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_display_field_group`
--

INSERT INTO `ohrm_display_field_group` (`id`, `report_group_id`, `name`, `is_list`) VALUES
(1, 3, 'Personal', 0),
(2, 3, 'Contact Details', 0),
(3, 3, 'Emergency Contacts', 1),
(4, 3, 'Dependents', 1),
(5, 3, 'Immigration', 1),
(6, 3, 'Job', 0),
(7, 3, 'Salary', 1),
(8, 3, 'Subordinates', 1),
(9, 3, 'Supervisors', 1),
(10, 3, 'Work Experience', 1),
(11, 3, 'Education', 1),
(12, 3, 'Skills', 1),
(13, 3, 'Languages', 1),
(14, 3, 'License', 1),
(15, 3, 'Memberships', 1),
(16, 3, 'Custom Fields', 0);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_display_field`
--

INSERT INTO `ohrm_display_field` (`display_field_id`, `report_group_id`, `name`, `label`, `field_alias`, `is_sortable`, `sort_order`, `sort_field`, `element_type`, `element_property`, `width`, `is_exportable`, `text_alignment_style`, `is_value_list`, `display_field_group_id`, `default_value`, `is_encrypted`, `is_meta`, `class_name`) VALUES
(1, 1, 'ohrm_project.name', 'Project Name', 'projectname', 'false', NULL, NULL, 'label', '<xml><getter>projectname</getter></xml>', '200', '0', NULL, 0, NULL, NULL, 0, 0, NULL),
(2, 1, 'ohrm_project_activity.name', 'Activity Name', 'activityname', 'false', NULL, NULL, 'link', '<xml><labelGetter>activityname</labelGetter><placeholderGetters><id>activity_id</id><total>totalduration</total><projectId>projectId</projectId><from>fromDate</from><to>toDate</to><approved>onlyIncludeApprovedTimesheets</approved></placeholderGetters><urlPattern>../../displayProjectActivityDetailsReport?reportId=3#activityId={id}#total={total}#from={from}#to={to}#projectId={projectId}#onlyIncludeApprovedTimesheets={approved}</urlPattern></xml>', '200', '0', NULL, 0, NULL, NULL, 0, 0, NULL),
(3, 1, 'ohrm_project_activity.project_id', 'Project Id', NULL, 'false', NULL, NULL, 'label', '<xml><getter>project_id</getter></xml>', '75', '0', 'right', 0, NULL, NULL, 0, 1, NULL),
(4, 1, 'ohrm_project_activity.activity_id', 'Activity Id', NULL, 'false', NULL, NULL, 'label', '<xml><getter>activity_id</getter></xml>', '75', '0', 'right', 0, NULL, NULL, 0, 1, NULL),
(5, 1, 'ohrm_timesheet_item.duration', 'Time (hours)', NULL, 'false', NULL, NULL, 'label', '<xml><getter>duration</getter></xml>', '75', '0', 'right', 0, NULL, NULL, 0, 0, NULL),
(6, 1, 'hs_hr_employee.emp_firstname', 'Employee First Name', NULL, 'false', NULL, NULL, 'label', '<xml><getter>emp_firstname</getter></xml>', '200', '0', NULL, 0, NULL, NULL, 0, 0, NULL),
(7, 1, 'hs_hr_employee.emp_lastname', 'Employee Last Name', NULL, 'false', NULL, NULL, 'label', '<xml><getter>emp_lastname</getter></xml>', '200', '0', NULL, 0, NULL, NULL, 0, 0, NULL),
(8, 1, 'ohrm_project_activity.name', 'Activity Name', 'activityname', 'false', NULL, NULL, 'label', '<xml><getter>activityname</getter></xml>', '200', '0', NULL, 0, NULL, NULL, 0, 0, NULL),
(9, 3, 'hs_hr_employee.employee_id', 'Employee Id', 'employeeId', 'false', NULL, NULL, 'label', '<xml><getter>employeeId</getter></xml>', '100', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(10, 3, 'hs_hr_employee.emp_lastname', 'Employee Last Name', 'employeeLastname', 'false', NULL, NULL, 'label', '<xml><getter>employeeLastname</getter></xml>', '200', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(11, 3, 'hs_hr_employee.emp_firstname', 'Employee First Name', 'employeeFirstname', 'false', NULL, NULL, 'label', '<xml><getter>employeeFirstname</getter></xml>', '200', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(12, 3, 'hs_hr_employee.emp_middle_name', 'Employee Middle Name', 'employeeMiddlename', 'false', NULL, NULL, 'label', '<xml><getter>employeeMiddlename</getter></xml>', '200', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(13, 3, 'hs_hr_employee.emp_birthday', 'Date of Birth', 'empBirthday', 'false', NULL, NULL, 'labelDate', '<xml><getter>empBirthday</getter></xml>', '100', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(14, 3, 'ohrm_nationality.name', 'Nationality', 'employeeNationality', 'false', NULL, NULL, 'label', '<xml><getter>nationality</getter></xml>', '200', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(15, 3, 'CASE hs_hr_employee.emp_gender WHEN 1 THEN \"Male\" WHEN 2 THEN \"Female\" WHEN 3 THEN \"Other\" END', 'Gender', 'empGender', 'false', NULL, NULL, 'label', '<xml><getter>empGender</getter></xml>', '80', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Personal\\EmployeeGender'),
(17, 3, 'hs_hr_employee.emp_marital_status', 'Marital Status', 'maritalStatus', 'false', NULL, NULL, 'label', '<xml><getter>maritalStatus</getter></xml>', '100', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(18, 3, 'hs_hr_employee.emp_dri_lice_num', 'Driver License Number', 'driversLicenseNumber', 'false', NULL, NULL, 'label', '<xml><getter>driversLicenseNumber</getter></xml>', '240', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(19, 3, 'hs_hr_employee.emp_dri_lice_exp_date', 'License Expiry Date', 'licenseExpiryDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>licenseExpiryDate</getter></xml>', '135', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(20, 3, 'CONCAT_WS(\", \", NULLIF(hs_hr_employee.emp_street1, \"\"), NULLIF(hs_hr_employee.emp_street2, \"\"), NULLIF(hs_hr_employee.city_code, \"\"), NULLIF(hs_hr_employee.provin_code,\"\"), NULLIF(hs_hr_employee.emp_zipcode,\"\"), NULLIF(hs_hr_country.cou_name,\"\"))', 'Address', 'address', 'false', NULL, NULL, 'label', '<xml><getter>address</getter></xml>', '200', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\ContactDetail\\EmployeeAddress'),
(21, 3, 'hs_hr_employee.emp_hm_telephone', 'Home Telephone', 'homeTelephone', 'false', NULL, NULL, 'label', '<xml><getter>homeTelephone</getter></xml>', '130', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(22, 3, 'hs_hr_employee.emp_mobile', 'Mobile', 'mobile', 'false', NULL, NULL, 'label', '<xml><getter>mobile</getter></xml>', '100', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(23, 3, 'hs_hr_employee.emp_work_telephone', 'Work Telephone', 'workTelephone', 'false', NULL, NULL, 'label', '<xml><getter>workTelephone</getter></xml>', '100', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(24, 3, 'hs_hr_employee.emp_work_email', 'Work Email', 'workEmail', 'false', NULL, NULL, 'label', '<xml><getter>workEmail</getter></xml>', '200', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(25, 3, 'hs_hr_employee.emp_oth_email', 'Other Email', 'otherEmail', 'false', NULL, NULL, 'label', '<xml><getter>otherEmail</getter></xml>', '200', '0', NULL, 0, 2, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(26, 3, 'hs_hr_emp_emergency_contacts.eec_name', 'Name', 'ecname', 'false', NULL, NULL, 'label', '<xml><getter>ecname</getter></xml>', '200', '0', NULL, 1, 3, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(27, 3, 'hs_hr_emp_emergency_contacts.eec_home_no', 'Home Telephone', 'ecHomeTelephone', 'false', NULL, NULL, 'label', '<xml><getter>ecHomeTelephone</getter></xml>', '130', '0', NULL, 1, 3, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(28, 3, 'hs_hr_emp_emergency_contacts.eec_office_no', 'Work Telephone', 'ecWorkTelephone', 'false', NULL, NULL, 'label', '<xml><getter>ecWorkTelephone</getter></xml>', '100', '0', NULL, 1, 3, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(29, 3, 'hs_hr_emp_emergency_contacts.eec_relationship', 'Relationship', 'ecRelationship', 'false', NULL, NULL, 'label', '<xml><getter>ecRelationship</getter></xml>', '200', '0', NULL, 1, 3, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(30, 3, 'hs_hr_emp_emergency_contacts.eec_mobile_no', 'Mobile', 'ecMobile', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 3, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(31, 3, 'hs_hr_emp_dependents.ed_name', 'Name', 'dependentName', 'false', NULL, NULL, 'label', '<xml><getter>dependentName</getter></xml>', '200', '0', NULL, 1, 4, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Dependent\\Dependent'),
(32, 3, 'IF (hs_hr_emp_dependents.ed_relationship_type = \'other\', hs_hr_emp_dependents.ed_relationship, hs_hr_emp_dependents.ed_relationship_type)', 'Relationship', 'dependentRelationship', 'false', NULL, NULL, 'label', '<xml><getter>dependentRelationship</getter></xml>', '200', '0', NULL, 1, 4, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Dependent\\Dependent'),
(33, 3, 'hs_hr_emp_dependents.ed_date_of_birth', 'Date of Birth', 'dependentDateofBirth', 'false', NULL, NULL, 'labelDate', '<xml><getter>dependentDateofBirth</getter></xml>', '100', '0', NULL, 1, 4, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Dependent\\Dependent'),
(35, 3, 'ohrm_membership.name', 'Membership', 'membershipName', 'false', NULL, NULL, 'label', '<xml><getter>name</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(36, 3, 'hs_hr_emp_member_detail.ememb_subscript_ownership', 'Subscription Paid By', 'subscriptionPaidBy', 'false', NULL, NULL, 'label', '<xml><getter>subscriptionPaidBy</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(37, 3, 'hs_hr_emp_member_detail.ememb_subscript_amount', 'Subscription Amount', 'subscriptionAmount', 'false', NULL, NULL, 'label', '<xml><getter>subscriptionAmount</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(38, 3, 'hs_hr_emp_member_detail.ememb_subs_currency', 'Currency', 'membershipCurrency', 'false', NULL, NULL, 'label', '<xml><getter>membershipCurrency</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(39, 3, 'hs_hr_emp_member_detail.ememb_commence_date', 'Subscription Commence Date', 'subscriptionCommenceDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>subscriptionCommenceDate</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(40, 3, 'hs_hr_emp_member_detail.ememb_renewal_date', 'Subscription Renewal Date', 'subscriptionRenewalDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>subscriptionRenewalDate</getter></xml>', '200', '0', NULL, 1, 15, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(41, 3, 'hs_hr_emp_work_experience.eexp_employer', 'Company', 'expCompany', 'false', NULL, NULL, 'label', '<xml><getter>expCompany</getter></xml>', '200', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(42, 3, 'hs_hr_emp_work_experience.eexp_jobtit', 'Job Title', 'expJobTitle', 'false', NULL, NULL, 'label', '<xml><getter>expJobTitle</getter></xml>', '200', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(43, 3, 'hs_hr_emp_work_experience.eexp_from_date', 'From', 'expFrom', 'false', NULL, NULL, 'labelDate', '<xml><getter>expFrom</getter></xml>', '100', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(44, 3, 'hs_hr_emp_work_experience.eexp_to_date', 'To', 'expTo', 'false', NULL, NULL, 'labelDate', '<xml><getter>expTo</getter></xml>', '100', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(45, 3, 'hs_hr_emp_work_experience.eexp_comments', 'Comment', 'expComment', 'false', NULL, NULL, 'label', '<xml><getter>expComment</getter></xml>', '200', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(47, 3, 'ohrm_education.name', 'Level', 'eduProgram', 'false', NULL, NULL, 'label', '<xml><getter>eduProgram</getter></xml>', '200', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(48, 3, 'ohrm_emp_education.year', 'Year', 'eduYear', 'false', NULL, NULL, 'label', '<xml><getter>eduYear</getter></xml>', '100', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(49, 3, 'ohrm_emp_education.score', 'Score', 'eduGPAOrScore', 'false', NULL, NULL, 'label', '<xml><getter>eduGPAOrScore</getter></xml>', '80', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(52, 3, 'ohrm_skill.name', 'Skill', 'skill', 'false', NULL, NULL, 'label', '<xml><getter>skill</getter></xml>', '200', '0', NULL, 1, 12, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Skill\\Skill'),
(53, 3, 'hs_hr_emp_skill.years_of_exp', 'Years of Experience', 'skillYearsOfExperience', 'false', NULL, NULL, 'label', '<xml><getter>skillYearsOfExperience</getter></xml>', '135', '0', NULL, 1, 12, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Skill\\Skill'),
(54, 3, 'hs_hr_emp_skill.comments', 'Comments', 'skillComments', 'false', NULL, NULL, 'label', '<xml><getter>skillComments</getter></xml>', '200', '0', NULL, 1, 12, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Skill\\Skill'),
(55, 3, 'ohrm_language.name', 'Language', 'langName', 'false', NULL, NULL, 'label', '<xml><getter>langName</getter></xml>', '200', '0', NULL, 1, 13, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(57, 3, 'CASE hs_hr_emp_language.competency WHEN 1 THEN \"Poor\" WHEN 2 THEN \"Basic\" WHEN 3 THEN \"Good\" WHEN 4 THEN \"Mother Tongue\" END', 'Competency', 'langCompetency', 'false', NULL, NULL, 'label', '<xml><getter>langCompetency</getter></xml>', '130', '0', NULL, 1, 13, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(58, 3, 'hs_hr_emp_language.comments', 'Comments', 'langComments', 'false', NULL, NULL, 'label', '<xml><getter>langComments</getter></xml>', '200', '0', NULL, 1, 13, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(59, 3, 'ohrm_license.name', 'License Type', 'empLicenseType', 'false', NULL, NULL, 'label', '<xml><getter>empLicenseType</getter></xml>', '200', '0', NULL, 1, 14, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\License\\License'),
(60, 3, 'ohrm_emp_license.license_issued_date', 'Issued Date', 'empLicenseIssuedDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empLicenseIssuedDate</getter></xml>', '100', '0', NULL, 1, 14, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\License\\License'),
(61, 3, 'ohrm_emp_license.license_expiry_date', 'Expiry Date', 'empLicenseExpiryDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empLicenseExpiryDate</getter></xml>', '100', '0', NULL, 1, 14, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\License\\License'),
(62, 3, 'supervisor.emp_firstname', 'First Name', 'supervisorFirstName', 'false', NULL, NULL, 'label', '<xml><getter>supervisorFirstName</getter></xml>', '200', '0', NULL, 1, 9, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Supervisor\\Supervisor'),
(63, 3, 'subordinate.emp_firstname', 'First Name', 'subordinateFirstName', 'false', NULL, NULL, 'label', '<xml><getter>subordinateFirstName</getter></xml>', '200', '0', NULL, 1, 8, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Subordinate\\Subordinate'),
(64, 3, 'supervisor.emp_lastname', 'Last Name', 'supervisorLastName', 'false', NULL, NULL, 'label', '<xml><getter>supervisorLastName</getter></xml>', '200', '0', NULL, 1, 9, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Supervisor\\Supervisor'),
(65, 3, 'ohrm_pay_grade.name', 'Pay Grade', 'salPayGrade', 'false', NULL, NULL, 'label', '<xml><getter>salPayGrade</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(66, 3, 'hs_hr_emp_basicsalary.salary_component', 'Salary Component', 'salSalaryComponent', 'false', NULL, NULL, 'label', '<xml><getter>salSalaryComponent</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(67, 3, 'hs_hr_emp_basicsalary.ebsal_basic_salary', 'Amount', 'salAmount', 'false', NULL, NULL, 'label', '<xml><getter>salAmount</getter></xml>', '200', '0', NULL, 1, 7, '---', 1, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(68, 3, 'hs_hr_emp_basicsalary.comments', 'Comments', 'salComments', 'false', NULL, NULL, 'label', '<xml><getter>salComments</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(69, 3, 'hs_hr_payperiod.payperiod_name', 'Pay Frequency', 'salPayFrequency', 'false', NULL, NULL, 'label', '<xml><getter>salPayFrequency</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(70, 3, 'hs_hr_currency_type.currency_name', 'Currency', 'salCurrency', 'false', NULL, NULL, 'label', '<xml><getter>salCurrency</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(71, 3, 'hs_hr_emp_directdebit.dd_account', 'Direct Deposit Account Number', 'ddAccountNumber', 'false', NULL, NULL, 'label', '<xml><getter>ddAccountNumber</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(72, 3, 'hs_hr_emp_directdebit.dd_account_type', 'Direct Deposit Account Type', 'ddAccountType', 'false', NULL, NULL, 'label', '<xml><getter>ddAccountType</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(73, 3, 'hs_hr_emp_directdebit.dd_routing_num', 'Direct Deposit Routing Number', 'ddRoutingNumber', 'false', NULL, NULL, 'label', '<xml><getter>ddRoutingNumber</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(74, 3, 'hs_hr_emp_directdebit.dd_amount', 'Direct Deposit Amount', 'ddAmount', 'false', NULL, NULL, 'label', '<xml><getter>ddAmount</getter></xml>', '200', '0', NULL, 1, 7, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(75, 3, 'hs_hr_emp_contract_extend.econ_extend_start_date', 'Contract Start Date', 'empContStartDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empContStartDate</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(76, 3, 'hs_hr_emp_contract_extend.econ_extend_end_date', 'Contract End Date', 'empContEndDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empContEndDate</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(77, 3, 'ohrm_job_title.job_title', 'Job Title', 'empJobTitle', 'false', NULL, NULL, 'label', '<xml><getter>empJobTitle</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(78, 3, 'ohrm_employment_status.name', 'Employment Status', 'empEmploymentStatus', 'false', NULL, NULL, 'label', '<xml><getter>empEmploymentStatus</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(80, 3, 'ohrm_job_category.name', 'Job Category', 'empJobCategory', 'false', NULL, NULL, 'label', '<xml><getter>empJobCategory</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(81, 3, 'hs_hr_employee.joined_date', 'Joined Date', 'empJoinedDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empJoinedDate</getter></xml>', '100', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(82, 3, 'ohrm_subunit.name', 'Sub Unit', 'empSubUnit', 'false', NULL, NULL, 'label', '<xml><getter>empSubUnit</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(83, 3, 'ohrm_location.name', 'Location', 'empLocation', 'false', NULL, NULL, 'label', '<xml><getter>empLocation</getter></xml>', '200', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(84, 3, 'hs_hr_emp_passport.ep_passport_num', 'Number', 'empPassportNo', 'false', NULL, NULL, 'label', '<xml><getter>empPassportNo</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(85, 3, 'hs_hr_emp_passport.ep_passportissueddate', 'Issued Date', 'empPassportIssuedDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empPassportIssuedDate</getter></xml>', '100', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(86, 3, 'hs_hr_emp_passport.ep_passportexpiredate', 'Expiry Date', 'empPassportExpiryDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empPassportExpiryDate</getter></xml>', '100', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(87, 3, 'hs_hr_emp_passport.ep_i9_status', 'Eligibility Status', 'empPassportEligibleStatus', 'false', NULL, NULL, 'label', '<xml><getter>empPassportEligibleStatus</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(88, 3, 'hs_hr_emp_passport.cou_code', 'Issued By', 'empPassportIssuedBy', 'false', NULL, NULL, 'label', '<xml><getter>empPassportIssuedBy</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(89, 3, 'hs_hr_emp_passport.ep_i9_review_date', 'Eligibility Review Date', 'empPassportEligibleReviewDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>empPassportEligibleReviewDate</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(90, 3, 'hs_hr_emp_passport.ep_comments', 'Comments', 'empPassportComments', 'false', NULL, NULL, 'label', '<xml><getter>empPassportComments</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(91, 3, 'subordinate.emp_lastname', 'Last Name', 'subordinateLastName', 'false', NULL, NULL, 'label', '<xml><getter>subordinateLastName</getter></xml>', '200', '0', NULL, 1, 8, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Subordinate\\Subordinate'),
(92, 3, 'CASE hs_hr_emp_language.fluency WHEN 1 THEN \"Writing\" WHEN 2 THEN \"Speaking\" WHEN 3 THEN \"Reading\" END', 'Fluency', 'langFluency', 'false', NULL, NULL, 'label', '<xml><getter>langFluency</getter></xml>', '200', '0', NULL, 1, 13, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(93, 3, 'supervisor_reporting_method.reporting_method_name', 'Reporting Method', 'supReportingMethod', 'false', NULL, NULL, 'label', '<xml><getter>supReportingMethod</getter></xml>', '200', '0', NULL, 1, 9, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Supervisor\\Supervisor'),
(94, 3, 'subordinate_reporting_method.reporting_method_name', 'Reporting Method', 'subReportingMethod', 'false', NULL, NULL, 'label', '<xml><getter>subReportingMethod</getter></xml>', '200', '0', NULL, 1, 8, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Subordinate\\Subordinate'),
(95, 3, 'CASE hs_hr_emp_passport.ep_passport_type_flg WHEN 1 THEN \"Passport\" WHEN 2 THEN \"Visa\" END', 'Document Type', 'documentType', 'false', NULL, NULL, 'label', '<xml><getter>documentType</getter></xml>', '200', '0', NULL, 1, 5, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(97, 3, 'hs_hr_employee.emp_other_id', 'Other Id', 'otherId', 'false', NULL, NULL, 'label', '<xml><getter>otherId</getter></xml>', '100', '0', NULL, 0, 1, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(98, 3, 'hs_hr_emp_emergency_contacts.eec_seqno', 'ecSeqNo', 'ecSeqNo', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 3, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\EmergencyContact\\EmergencyContact'),
(99, 3, 'hs_hr_emp_dependents.ed_seqno', 'SeqNo', 'edSeqNo', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 4, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Dependent\\Dependent'),
(100, 3, 'hs_hr_emp_passport.ep_seqno', 'SeqNo', 'epSeqNo', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 5, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Immigration\\Immigration'),
(101, 3, 'hs_hr_emp_basicsalary.id', 'salaryId', 'salaryId', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 7, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Salary\\Salary'),
(102, 3, 'subordinate.emp_number', 'subordinateId', 'subordinateId', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 8, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Subordinate\\Subordinate'),
(103, 3, 'supervisor.emp_number', 'supervisorId', 'supervisorId', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 9, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Supervisor\\Supervisor'),
(104, 3, 'hs_hr_emp_work_experience.eexp_seqno', 'workExpSeqNo', 'workExpSeqNo', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 10, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(105, 3, 'ohrm_emp_education.education_id', 'empEduCode', 'empEduCode', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 11, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(106, 3, 'hs_hr_emp_skill.skill_id', 'empSkillCode', 'empSkillCode', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 12, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Skill\\Skill'),
(107, 3, 'hs_hr_emp_language.lang_id', 'empLangCode', 'empLangCode', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 13, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(108, 3, 'hs_hr_emp_language.fluency', 'empLangType', 'empLangType', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 13, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Language\\Language'),
(109, 3, 'ohrm_emp_license.license_id', 'empLicenseCode', 'empLicenseCode', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 14, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\License\\License'),
(110, 3, 'hs_hr_emp_member_detail.membship_code', 'membershipCode', 'membershipCode', 'false', NULL, NULL, 'label', '<xml><getter>ecMobile</getter></xml>', '100', '0', NULL, 1, 15, '---', 0, 1, 'OrangeHRM\\Core\\Report\\DisplayField\\Membership\\Membership'),
(112, 3, 'ROUND(DATEDIFF(hs_hr_emp_work_experience.eexp_to_date, hs_hr_emp_work_experience.eexp_from_date)/365,1)', 'Duration', 'expDuration', 'false', NULL, NULL, 'label', '<xml><getter>expDuration</getter></xml>', '100', '0', NULL, 1, 10, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\WorkExperience\\WorkExperience'),
(113, 3, 'ohrm_emp_termination.termination_date', 'Termination Date', 'terminationDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>terminationDate</getter></xml>', '100', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericDateDisplayField'),
(114, 3, 'ohrm_emp_termination_reason.name', 'Termination Reason', 'empTerminationReason', 'false', NULL, NULL, 'label', '<xml><getter>terminationReason</getter></xml>', '100', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField'),
(115, 3, 'ohrm_emp_education.institute', 'Institute', 'getInstitute', 'false', NULL, NULL, 'label', '<xml><getter>getInstitute</getter></xml>', '80', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(116, 3, 'ohrm_emp_education.major', 'Major/Specialization', 'getMajor', 'false', NULL, NULL, 'label', '<xml><getter>getMajor</getter></xml>', '80', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(117, 3, 'ohrm_emp_education.start_date', 'Start Date', 'getStartDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>getStartDate</getter></xml>', '80', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(118, 3, 'ohrm_emp_education.end_date', 'End Date', 'getEndDate', 'false', NULL, NULL, 'labelDate', '<xml><getter>getEndDate</getter></xml>', '80', '0', NULL, 1, 11, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\Education\\Education'),
(119, 3, 'ohrm_emp_license.license_no', 'License Number', 'getLicenseNo', 'false', NULL, NULL, 'label', '<xml><getter>getLicenseNo</getter></xml>', '200', '0', NULL, 1, 14, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\License\\License'),
(120, 3, 'ohrm_emp_termination.note', 'Termination Note', 'terminationNote', 'false', NULL, NULL, 'label', '<xml><getter>getNote</getter></xml>', '100', '0', NULL, 0, 6, '---', 0, 0, 'OrangeHRM\\Core\\Report\\DisplayField\\GenericBasicDisplayField');

-- --------------------------------------------------------

--
-- Dumping data for table `ohrm_education`
--

INSERT INTO `ohrm_education` (`id`, `organizationId`, `name`) VALUES
(1, 53, 'test');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_email`
--

INSERT INTO `ohrm_email` (`id`, `name`) VALUES
(1, 'leave.apply'),
(3, 'leave.approve'),
(2, 'leave.assign'),
(4, 'leave.cancel'),
(6, 'leave.change'),
(5, 'leave.reject');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_email_notification`
--

INSERT INTO `ohrm_email_notification` (`id`, `name`, `is_enable`) VALUES
(1, 'Leave Applications', 0),
(2, 'Leave Assignments', 0),
(3, 'Leave Approvals', 0),
(4, 'Leave Cancellations', 1),
(5, 'Leave Rejections', 0);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_email_processor`
--

INSERT INTO `ohrm_email_processor` (`id`, `email_id`, `class_name`) VALUES
(1, 1, 'OrangeHRM\\Leave\\Mail\\Processor\\LeaveAllocateEmailProcessor'),
(2, 2, 'OrangeHRM\\Leave\\Mail\\Processor\\LeaveAllocateEmailProcessor'),
(3, 3, 'OrangeHRM\\Leave\\Mail\\Processor\\LeaveStatusChangeEmailProcessor'),
(4, 4, 'OrangeHRM\\Leave\\Mail\\Processor\\LeaveStatusChangeEmailProcessor'),
(5, 5, 'OrangeHRM\\Leave\\Mail\\Processor\\LeaveStatusChangeEmailProcessor'),
(6, 6, 'LeaveChangeMailProcessor');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_email_template`
--

INSERT INTO `ohrm_email_template` (`id`, `email_id`, `locale`, `performer_role`, `recipient_role`, `subject`, `body`) VALUES
(1, 1, 'en_US', NULL, 'supervisor', '/orangehrmLeavePlugin/Mail/templates/en_US/apply/leaveApplicationSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/apply/leaveApplicationBody.html.twig'),
(2, 1, 'en_US', NULL, 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/apply/leaveApplicationSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/apply/leaveApplicationSubscriberBody.html.twig'),
(3, 3, 'en_US', NULL, 'ess', '/orangehrmLeavePlugin/Mail/templates/en_US/approve/leaveApprovalSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/approve/leaveApprovalBody.html.twig'),
(4, 3, 'en_US', NULL, 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/approve/leaveApprovalSubscriberSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/approve/leaveApprovalSubscriberBody.html.twig'),
(5, 2, 'en_US', NULL, 'ess', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentBody.html.twig'),
(6, 2, 'en_US', NULL, 'supervisor', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentSubjectForSupervisors.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentBodyForSupervisors.html.twig'),
(7, 2, 'en_US', NULL, 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentSubscriberSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/assign/leaveAssignmentSubscriberBody.html.twig'),
(8, 4, 'en_US', 'ess', 'supervisor', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveEmployeeCancellationSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveEmployeeCancellationBody.html.twig'),
(9, 4, 'en_US', 'ess', 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveEmployeeCancellationSubscriberSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveEmployeeCancellationSubscriberBody.html.twig'),
(10, 4, 'en_US', NULL, 'ess', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveCancellationSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveCancellationBody.html.twig'),
(11, 4, 'en_US', NULL, 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveCancellationSubscriberSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/cancel/leaveCancellationSubscriberBody.html.twig'),
(12, 5, 'en_US', NULL, 'ess', '/orangehrmLeavePlugin/Mail/templates/en_US/reject/leaveRejectionSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/reject/leaveRejectionBody.html.twig'),
(13, 5, 'en_US', NULL, 'subscriber', '/orangehrmLeavePlugin/Mail/templates/en_US/reject/leaveRejectionSubscriberSubject.txt.twig', '/orangehrmLeavePlugin/Mail/templates/en_US/reject/leaveRejectionSubscriberBody.html.twig'),
(14, 6, 'en_US', NULL, 'ess', 'orangehrmLeavePlugin/modules/leave/templates/mail/en_US/change/leaveChangeSubject.txt', 'orangehrmLeavePlugin/modules/leave/templates/mail/en_US/change/leaveChangeBody.txt'),
(15, 6, 'en_US', NULL, 'subscriber', 'orangehrmLeavePlugin/modules/leave/templates/mail/en_US/change/leaveChangeSubscriberSubject.txt', 'orangehrmLeavePlugin/modules/leave/templates/mail/en_US/change/leaveChangeSubscriberBody.txt');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_employee_event`
--

INSERT INTO `ohrm_employee_event` (`event_id`, `employee_id`, `type`, `event`, `note`, `created_date`, `created_by`) VALUES
(1, 2, 'employee', 'SAVE', 'Saving Employee', '2022-10-28 17:19:25', 'Admin'),
(2, 3, 'employee', 'SAVE', 'Saving Employee', '2022-11-08 14:28:57', 'Admin'),
(3, 1, 'employee', 'UPDATE', 'Updating Employee Details', '2022-11-11 00:17:27', 'Admin'),
(4, 52, 'employee', 'SAVE', 'Saving Employee', '2023-01-02 09:05:33', 'Admin'),
(5, 53, 'employee', 'SAVE', 'Saving Employee', '2023-01-04 18:09:46', 'Admin'),
(6, 54, 'employee', 'SAVE', 'Saving Employee', '2023-01-04 18:20:16', 'Admin'),
(7, 55, 'employee', 'SAVE', 'Saving Employee', '2023-01-04 19:00:53', 'Admin'),
(8, 55, 'employee', 'UPDATE', 'Updating Employee Details', '2023-01-04 19:01:41', 'Admin'),
(9, 56, 'employee', 'SAVE', 'Saving Employee', '2023-01-04 19:03:56', 'Admin'),
(10, 56, 'employee', 'UPDATE', 'Updating Employee Details', '2023-01-04 19:04:33', 'Admin'),
(11, 57, 'employee', 'SAVE', 'Saving Employee', '2023-01-04 19:13:37', 'Admin');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_work_shift`
--

INSERT INTO `ohrm_work_shift` (`id`, `organizationId`, `name`, `hours_per_day`, `start_time`, `end_time`) VALUES
(1, 1, 'Daily work', '8.00', '09:00:00', '17:00:00'),
(2, 53, 'Hourly work', '9.00', '09:00:00', '18:00:00');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_employee_work_shift`
--

INSERT INTO `ohrm_employee_work_shift` (`work_shift_id`, `emp_number`) VALUES
(1, 42),
(2, 51);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_employment_status`
--

INSERT INTO `ohrm_employment_status` (`id`, `organizationId`, `name`) VALUES
(1, 53, 'Active');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_emp_reporting_method`
--

INSERT INTO `ohrm_emp_reporting_method` (`reporting_method_id`, `reporting_method_name`) VALUES
(1, 'Direct'),
(2, 'Indirect');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_emp_termination_reason`
--

INSERT INTO `ohrm_emp_termination_reason` (`id`, `name`) VALUES
(1, 'Other'),
(2, 'Retired'),
(3, 'Contract Not Renewed'),
(4, 'Resigned - Company Requested'),
(5, 'Resigned - Self Proposed'),
(6, 'Resigned'),
(7, 'Deceased'),
(8, 'Physically Disabled/Compensated'),
(9, 'Laid-off'),
(10, 'Dismissed');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_filter_field`
--

INSERT INTO `ohrm_filter_field` (`filter_field_id`, `report_group_id`, `name`, `where_clause_part`, `filter_field_widget`, `condition_no`, `required`, `class_name`) VALUES
(1, 1, 'project_name', 'ohrm_project.project_id', 'ohrmWidgetProjectList', 2, 'true', NULL),
(2, 1, 'activity_show_deleted', 'ohrm_project_activity.is_deleted', 'ohrmWidgetInputCheckbox', 2, 'false', NULL),
(3, 1, 'project_date_range', 'date', 'ohrmWidgetDateRange', 1, 'false', NULL),
(4, 1, 'employee', 'hs_hr_employee.emp_number', 'ohrmReportWidgetEmployeeListAutoFill', 2, 'true', NULL),
(5, 1, 'activity_name', 'ohrm_project_activity.activity_id', 'ohrmWidgetProjectActivityList', 2, 'true', NULL),
(6, 1, 'project_name', 'ohrm_project.project_id', 'ohrmWidgetProjectListWithAllOption', 2, 'true', NULL),
(7, 1, 'only_include_approved_timesheets', 'ohrm_timesheet.state', 'ohrmWidgetApprovedTimesheetInputCheckBox', 2, NULL, NULL),
(8, 3, 'employee_name', 'hs_hr_employee.emp_number', 'ohrmReportWidgetEmployeeListAutoFill', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmployeeNumber'),
(9, 3, 'pay_grade', 'hs_hr_emp_basicsalary.sal_grd_code', 'ohrmReportWidgetPayGradeDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\PayGrade'),
(10, 3, 'education', 'ohrm_emp_education.education_id', 'ohrmReportWidgetEducationtypeDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmployeeEducation'),
(11, 3, 'employment_status', 'hs_hr_employee.emp_status', 'ohrmWidgetEmploymentStatusList', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmploymentStatus'),
(12, 3, 'service_period', 'datediff(current_date(), hs_hr_employee.joined_date)/365', 'ohrmReportWidgetServicePeriod', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\ServicePeriod'),
(13, 3, 'joined_date', 'hs_hr_employee.joined_date', 'ohrmReportWidgetJoinedDate', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\JoinedDate'),
(14, 3, 'job_title', 'hs_hr_employee.job_title_code', 'ohrmWidgetJobTitleList', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\JobTitle'),
(15, 3, 'language', 'hs_hr_emp_language.lang_id', 'ohrmReportWidgetLanguageDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmployeeLanguage'),
(16, 3, 'skill', 'hs_hr_emp_skill.skill_id', 'ohrmReportWidgetSkillDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmployeeSkill'),
(17, 3, 'age_group', 'datediff(current_date(), hs_hr_employee.emp_birthday)/365', 'ohrmReportWidgetAgeGroup', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\AgeGroup'),
(18, 3, 'sub_unit', 'hs_hr_employee.work_station', 'ohrmWidgetSubDivisionList', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\Subunit'),
(19, 3, 'gender', 'hs_hr_employee.emp_gender', 'ohrmReportWidgetGenderDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\EmployeeGender'),
(20, 3, 'location', 'ohrm_location.id', 'ohrmReportWidgetOperationalCountryLocationDropDown', 1, NULL, 'OrangeHRM\\Core\\Report\\FilterField\\Location'),
(21, 1, 'is_deleted', 'ohrm_project_activity.is_deleted', '', 2, NULL, NULL),
(22, 3, 'include', 'hs_hr_employee.termination_id', 'ohrmReportWidgetIncludedEmployeesDropDown', 1, 'true', 'OrangeHRM\\Core\\Report\\FilterField\\IncludeEmployee');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_group_field`
--

INSERT INTO `ohrm_group_field` (`group_field_id`, `name`, `group_by_clause`, `group_field_widget`) VALUES
(1, 'activity id', 'GROUP BY ohrm_project_activity.activity_id', NULL),
(2, 'employee number', 'GROUP BY hs_hr_employee.emp_number', NULL);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_user_role`
--

INSERT INTO `ohrm_user_role` (`id`, `name`, `display_name`, `is_assignable`, `is_predefined`) VALUES
(1, 'Admin', 'Admin', 1, 1),
(2, 'ESS', 'ESS', 1, 1),
(3, 'Supervisor', 'Supervisor', 0, 1),
(4, 'ProjectAdmin', 'ProjectAdmin', 0, 1),
(5, 'Interviewer', 'Interviewer', 0, 1),
(6, 'HiringManager', 'HiringManager', 0, 1),
(7, 'Reviewer', 'Reviewer', 0, 1);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_home_page`
--

INSERT INTO `ohrm_home_page` (`id`, `user_role_id`, `action`, `enable_class`, `priority`) VALUES
(1, 1, 'dashboard/index', NULL, 15),
(2, 2, 'dashboard/index', NULL, 5);

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_i18n_group`
--

INSERT INTO `ohrm_i18n_group` (`id`, `name`, `title`) VALUES
(1, 'general', 'General'),
(2, 'admin', 'Admin'),
(3, 'pim', 'PIM'),
(4, 'leave', 'Leave'),
(5, 'time', 'Time'),
(6, 'recruitment', 'Recruitment'),
(7, 'performance', 'Performance'),
(8, 'dashboard', 'Dashboard'),
(10, 'maintenance', 'Maintenance'),
(11, 'buzz', 'Buzz'),
(12, 'marketplace', 'Marketplace'),
(13, 'mobile', 'Mobile'),
(14, 'help', 'Help'),
(17, 'attendance', 'Attendance'),
(19, 'auth', 'Auth');

-- --------------------------------------------------------
--
-- Dumping data for table `ohrm_i18n_language`
--

INSERT INTO `ohrm_i18n_language` (`id`, `name`, `code`, `enabled`, `added`, `modified_at`) VALUES
(1, 'Chinese (Simplified, China) - 中文（简体，中国）', 'zh_Hans_CN', 1, 1, NULL),
(2, 'Chinese (Traditional, Taiwan) - 中文（繁體，台灣）', 'zh_Hant_TW', 1, 1, NULL),
(3, 'Dutch - Nederlands', 'nl', 1, 1, NULL),
(4, 'English (United States)', 'en_US', 1, 1, NULL),
(5, 'French - Français', 'fr', 1, 1, NULL),
(6, 'German - Deutsch', 'de', 1, 1, NULL),
(7, 'Spanish - Español', 'es', 1, 1, NULL),
(8, 'Spanish (Costa Rica) - Español (Costa Rica)', 'es_CR', 1, 1, NULL),
(9, 'test - TEST', 'zz_ZZ', 0, 0, NULL),
(10, 'Afrikaans (Namibia) - Afrikaans (Namibië)', 'af_NA', 1, 0, NULL),
(11, 'Afrikaans (South Africa) - Afrikaans (Suid-Afrika)', 'af_ZA', 1, 0, NULL),
(12, 'Aghem (Cameroon)', 'agq_CM', 1, 0, NULL),
(13, 'Akan (Ghana)', 'ak_GH', 1, 0, NULL),
(14, 'Albanian (Albania) - Albanian (Albania)', 'sq_AL', 1, 0, NULL),
(15, 'Albanian (Macedonia) - Albanian (Macedonia)', 'sq_MK', 1, 0, NULL),
(16, 'Amharic (Ethiopia) - Amharic (Ethiopia)', 'am_ET', 1, 0, NULL),
(17, 'Arabic (Algeria) - العربية (الجزائر)', 'ar_DZ', 1, 0, NULL),
(18, 'Arabic (Bahrain) - العربية (البحرين)', 'ar_BH', 1, 0, NULL),
(19, 'Arabic (Chad) - العربية (تشاد)', 'ar_TD', 1, 0, NULL),
(20, 'Arabic (Comoros) - العربية (جزر القمر)', 'ar_KM', 1, 0, NULL),
(21, 'Arabic (Djibouti) - العربية (جيبوتي)', 'ar_DJ', 1, 0, NULL),
(22, 'Arabic (Egypt) - العربية (مصر)', 'ar_EG', 1, 0, NULL),
(23, 'Arabic (Eritrea) - العربية (إريتريا)', 'ar_ER', 1, 0, NULL),
(24, 'Arabic (Iraq) - العربية (العراق)', 'ar_IQ', 1, 0, NULL),
(25, 'Arabic (Israel) - العربية (إسرائيل)', 'ar_IL', 1, 0, NULL),
(26, 'Arabic (Jordan) - العربية (الأردن)', 'ar_JO', 1, 0, NULL),
(27, 'Arabic (Kuwait) - العربية (الكويت)', 'ar_KW', 1, 0, NULL),
(28, 'Arabic (Lebanon) - العربية (لبنان)', 'ar_LB', 1, 0, NULL),
(29, 'Arabic (Libya) - العربية (ليبيا)', 'ar_LY', 1, 0, NULL),
(30, 'Arabic (Mauritania) - العربية (موريتانيا)', 'ar_MR', 1, 0, NULL),
(31, 'Arabic (Morocco) - العربية (المغرب)', 'ar_MA', 1, 0, NULL),
(32, 'Arabic (Oman) - العربية (عمان)', 'ar_OM', 1, 0, NULL),
(33, 'Arabic (Palestinian Territories) - العربية (الأراضي الفلسطينية)', 'ar_PS', 1, 0, NULL),
(34, 'Arabic (Qatar) - العربية (قطر)', 'ar_QA', 1, 0, NULL),
(35, 'Arabic (Saudi Arabia) - العربية (المملكة العربية السعودية)', 'ar_SA', 1, 0, NULL),
(36, 'Arabic (Somalia) - العربية (الصومال)', 'ar_SO', 1, 0, NULL),
(37, 'Arabic (South Sudan) - العربية (جنوب السودان)', 'ar_SS', 1, 0, NULL),
(38, 'Arabic (Sudan) - العربية (السودان)', 'ar_SD', 1, 0, NULL),
(39, 'Arabic (Syria) - العربية (سوريا)', 'ar_SY', 1, 0, NULL),
(40, 'Arabic (Tunisia) - العربية (تونس)', 'ar_TN', 1, 0, NULL),
(41, 'Arabic (United Arab Emirates) - العربية (الإمارات العربية المتحدة)', 'ar_AE', 1, 0, NULL),
(42, 'Arabic (Western Sahara) - العربية (الصحراء الغربية)', 'ar_EH', 1, 0, NULL),
(43, 'Arabic (Yemen) - العربية (اليمن)', 'ar_YE', 1, 0, NULL),
(44, 'Armenian (Armenia) - Հայերեն (Հայաստան)', 'hy_AM', 1, 0, NULL),
(45, 'Assamese (India)', 'as_IN', 1, 0, NULL),
(46, 'Asturian (Spain)', 'ast_ES', 1, 0, NULL),
(47, 'Asu (Tanzania)', 'asa_TZ', 1, 0, NULL),
(48, 'Azerbaijani (Cyrillic, Azerbaijan) - Azərbaycan (kiril, Azərbaycan)', 'az_Cyrl_AZ', 1, 0, NULL),
(49, 'Azerbaijani (Latin, Azerbaijan) - Azərbaycan (Latın, Azərbaycan)', 'az_Latn_AZ', 1, 0, NULL),
(50, 'Bafia (Cameroon)', 'ksf_CM', 1, 0, NULL),
(51, 'Bambara (Mali)', 'bm_ML', 1, 0, NULL),
(52, 'Bangla (Bangladesh) - বাংলা (বাংলাদেশ)', 'bn_BD', 1, 0, NULL),
(53, 'Bangla (India) - বাংলা (ভারত)', 'bn_IN', 1, 0, NULL),
(54, 'Basaa (Cameroon)', 'bas_CM', 1, 0, NULL),
(55, 'Basque (Spain) - Basque (Espainia)', 'eu_ES', 1, 0, NULL),
(56, 'Belarusian (Belarus) - Беларуская (Беларусь)', 'be_BY', 1, 0, NULL),
(57, 'Bemba (Zambia)', 'bem_ZM', 1, 0, NULL),
(58, 'Bena (Tanzania)', 'bez_TZ', 1, 0, NULL),
(59, 'Bodo (India)', 'brx_IN', 1, 0, NULL),
(60, 'Bosnian (Cyrillic, Bosnia & Herzegovina) - Bosanski (ćirilica, Bosna i Hercegovina)', 'bs_Cyrl_BA', 1, 0, NULL),
(61, 'Bosnian (Latin, Bosnia & Herzegovina) - Bosanski (latinica, Bosna i Hercegovina)', 'bs_Latn_BA', 1, 0, NULL),
(62, 'Breton (France)', 'br_FR', 1, 0, NULL),
(63, 'Bulgarian (Bulgaria) - Български (България)', 'bg_BG', 1, 0, NULL),
(64, 'Burmese (Myanmar [Burma]) - မြန်မာ (မြန်မာ [မြန်မာနိုင်ငံ])', 'my_MM', 1, 0, NULL),
(65, 'Cantonese (Simplified, China) - 广东话（简体中文）', 'yue_Hans_CN', 1, 0, NULL),
(66, 'Cantonese (Traditional, Hong Kong SAR China) - 粵語（繁體中文，中國香港特別行政區）', 'yue_Hant_HK', 1, 0, NULL),
(67, 'Catalan (Andorra) - Català (Andorra)', 'ca_AD', 1, 0, NULL),
(68, 'Catalan (France) - Català (França)', 'ca_FR', 1, 0, NULL),
(69, 'Catalan (Italy) - Català (Itàlia)', 'ca_IT', 1, 0, NULL),
(70, 'Catalan (Spain) - Català (Espanya)', 'ca_ES', 1, 0, NULL),
(71, 'Central Atlas Tamazight (Morocco)', 'tzm_MA', 1, 0, NULL),
(72, 'Central Kurdish (Iran)', 'ckb_IR', 1, 0, NULL),
(73, 'Central Kurdish (Iraq)', 'ckb_IQ', 1, 0, NULL),
(74, 'Chakma (Bangladesh)', 'ccp_BD', 1, 0, NULL),
(75, 'Chakma (India)', 'ccp_IN', 1, 0, NULL),
(76, 'Chechen (Russia)', 'ce_RU', 1, 0, NULL),
(77, 'Cherokee (United States)', 'chr_US', 1, 0, NULL),
(78, 'Chiga (Uganda)', 'cgg_UG', 1, 0, NULL),
(79, 'Chinese (Simplified, Hong Kong SAR China) - 中文（简体，中国香港特别行政区）', 'zh_Hans_HK', 1, 0, NULL),
(80, 'Chinese (Simplified, Macau SAR China) - 中文（简体，中国澳门特别行政区）', 'zh_Hans_MO', 1, 0, NULL),
(81, 'Chinese (Simplified, Singapore) - 中文（简体，新加坡）', 'zh_Hans_SG', 1, 0, NULL),
(82, 'Chinese (Traditional, Hong Kong SAR China) - 中文（繁體字，中國香港特別行政區）', 'zh_Hant_HK', 1, 0, NULL),
(83, 'Chinese (Traditional, Macau SAR China) - 中文（繁體字，中國澳門特別行政區）', 'zh_Hant_MO', 1, 0, NULL),
(84, 'Colognian (Germany)', 'ksh_DE', 1, 0, NULL),
(85, 'Cornish (United Kingdom)', 'kw_GB', 1, 0, NULL),
(86, 'Croatian (Bosnia & Herzegovina) - Hrvatska (Bosna i Hercegovina)', 'hr_BA', 1, 0, NULL),
(87, 'Croatian (Croatia) - Hrvatski (Hrvatska)', 'hr_HR', 1, 0, NULL),
(88, 'Czech (Czechia) - Český (Česko)', 'cs_CZ', 1, 0, NULL),
(89, 'Danish (Denmark) - Dansk (Danmark)', 'da_DK', 1, 0, NULL),
(90, 'Danish (Greenland) - Dansk (Grønland)', 'da_GL', 1, 0, NULL),
(91, 'Duala (Cameroon)', 'dua_CM', 1, 0, NULL),
(92, 'Dutch (Aruba) - Nederlands (Aruba)', 'nl_AW', 1, 0, NULL),
(93, 'Dutch (Belgium) - Nederlands (België)', 'nl_BE', 1, 0, NULL),
(94, 'Dutch (Caribbean Netherlands) - Nederlands (Caribisch Nederland)', 'nl_BQ', 1, 0, NULL),
(95, 'Dutch (Curaçao) - Nederlands (Curaçao)', 'nl_CW', 1, 0, NULL),
(96, 'Dutch (Netherlands) - Nederlands (Nederland)', 'nl_NL', 1, 0, NULL),
(97, 'Dutch (Sint Maarten) - Nederlands (Sint Maarten)', 'nl_SX', 1, 0, NULL),
(98, 'Dutch (Suriname) - Nederlands (Suriname)', 'nl_SR', 1, 0, NULL),
(99, 'Dzongkha (Bhutan)', 'dz_BT', 1, 0, NULL),
(100, 'Embu (Kenya)', 'ebu_KE', 1, 0, NULL),
(101, 'English (American Samoa)', 'en_AS', 1, 0, NULL),
(102, 'English (Anguilla)', 'en_AI', 1, 0, NULL),
(103, 'English (Antigua & Barbuda)', 'en_AG', 1, 0, NULL),
(104, 'English (Australia)', 'en_AU', 1, 0, NULL),
(105, 'English (Austria)', 'en_AT', 1, 0, NULL),
(106, 'English (Bahamas)', 'en_BS', 1, 0, NULL),
(107, 'English (Barbados)', 'en_BB', 1, 0, NULL),
(108, 'English (Belgium)', 'en_BE', 1, 0, NULL),
(109, 'English (Belize)', 'en_BZ', 1, 0, NULL),
(110, 'English (Bermuda)', 'en_BM', 1, 0, NULL),
(111, 'English (Botswana)', 'en_BW', 1, 0, NULL),
(112, 'English (British Indian Ocean Territory)', 'en_IO', 1, 0, NULL),
(113, 'English (British Virgin Islands)', 'en_VG', 1, 0, NULL),
(114, 'English (Burundi)', 'en_BI', 1, 0, NULL),
(115, 'English (Cameroon)', 'en_CM', 1, 0, NULL),
(116, 'English (Canada)', 'en_CA', 1, 0, NULL),
(117, 'English (Cayman Islands)', 'en_KY', 1, 0, NULL),
(118, 'English (Christmas Island)', 'en_CX', 1, 0, NULL),
(119, 'English (Cocos [Keeling] Islands)', 'en_CC', 1, 0, NULL),
(120, 'English (Cook Islands)', 'en_CK', 1, 0, NULL),
(121, 'English (Cyprus)', 'en_CY', 1, 0, NULL),
(122, 'English (Denmark)', 'en_DK', 1, 0, NULL),
(123, 'English (Dominica)', 'en_DM', 1, 0, NULL),
(124, 'English (Eritrea)', 'en_ER', 1, 0, NULL),
(125, 'English (Falkland Islands)', 'en_FK', 1, 0, NULL),
(126, 'English (Fiji)', 'en_FJ', 1, 0, NULL),
(127, 'English (Finland)', 'en_FI', 1, 0, NULL),
(128, 'English (Gambia)', 'en_GM', 1, 0, NULL),
(129, 'English (Germany)', 'en_DE', 1, 0, NULL),
(130, 'English (Ghana)', 'en_GH', 1, 0, NULL),
(131, 'English (Gibraltar)', 'en_GI', 1, 0, NULL),
(132, 'English (Grenada)', 'en_GD', 1, 0, NULL),
(133, 'English (Guam)', 'en_GU', 1, 0, NULL),
(134, 'English (Guernsey)', 'en_GG', 1, 0, NULL),
(135, 'English (Guyana)', 'en_GY', 1, 0, NULL),
(136, 'English (Hong Kong SAR China)', 'en_HK', 1, 0, NULL),
(137, 'English (India)', 'en_IN', 1, 0, NULL),
(138, 'English (Ireland)', 'en_IE', 1, 0, NULL),
(139, 'English (Isle of Man)', 'en_IM', 1, 0, NULL),
(140, 'English (Israel)', 'en_IL', 1, 0, NULL),
(141, 'English (Jamaica)', 'en_JM', 1, 0, NULL),
(142, 'English (Jersey)', 'en_JE', 1, 0, NULL),
(143, 'English (Kenya)', 'en_KE', 1, 0, NULL),
(144, 'English (Kiribati)', 'en_KI', 1, 0, NULL),
(145, 'English (Lesotho)', 'en_LS', 1, 0, NULL),
(146, 'English (Liberia)', 'en_LR', 1, 0, NULL),
(147, 'English (Macau SAR China)', 'en_MO', 1, 0, NULL),
(148, 'English (Madagascar)', 'en_MG', 1, 0, NULL),
(149, 'English (Malawi)', 'en_MW', 1, 0, NULL),
(150, 'English (Malaysia)', 'en_MY', 1, 0, NULL),
(151, 'English (Malta)', 'en_MT', 1, 0, NULL),
(152, 'English (Marshall Islands)', 'en_MH', 1, 0, NULL),
(153, 'English (Mauritius)', 'en_MU', 1, 0, NULL),
(154, 'English (Micronesia)', 'en_FM', 1, 0, NULL),
(155, 'English (Montserrat)', 'en_MS', 1, 0, NULL),
(156, 'English (Namibia)', 'en_NA', 1, 0, NULL),
(157, 'English (Nauru)', 'en_NR', 1, 0, NULL),
(158, 'English (Netherlands)', 'en_NL', 1, 0, NULL),
(159, 'English (New Zealand)', 'en_NZ', 1, 0, NULL),
(160, 'English (Nigeria)', 'en_NG', 1, 0, NULL),
(161, 'English (Niue)', 'en_NU', 1, 0, NULL),
(162, 'English (Norfolk Island)', 'en_NF', 1, 0, NULL),
(163, 'English (Northern Mariana Islands)', 'en_MP', 1, 0, NULL),
(164, 'English (Pakistan)', 'en_PK', 1, 0, NULL),
(165, 'English (Palau)', 'en_PW', 1, 0, NULL),
(166, 'English (Papua New Guinea)', 'en_PG', 1, 0, NULL),
(167, 'English (Philippines)', 'en_PH', 1, 0, NULL),
(168, 'English (Pitcairn Islands)', 'en_PN', 1, 0, NULL),
(169, 'English (Puerto Rico)', 'en_PR', 1, 0, NULL),
(170, 'English (Rwanda)', 'en_RW', 1, 0, NULL),
(171, 'English (Samoa)', 'en_WS', 1, 0, NULL),
(172, 'English (Seychelles)', 'en_SC', 1, 0, NULL),
(173, 'English (Sierra Leone)', 'en_SL', 1, 0, NULL),
(174, 'English (Singapore)', 'en_SG', 1, 0, NULL),
(175, 'English (Sint Maarten)', 'en_SX', 1, 0, NULL),
(176, 'English (Slovenia)', 'en_SI', 1, 0, NULL),
(177, 'English (Solomon Islands)', 'en_SB', 1, 0, NULL),
(178, 'English (South Africa)', 'en_ZA', 1, 0, NULL),
(179, 'English (South Sudan)', 'en_SS', 1, 0, NULL),
(180, 'English (St. Helena)', 'en_SH', 1, 0, NULL),
(181, 'English (St. Kitts & Nevis)', 'en_KN', 1, 0, NULL),
(182, 'English (St. Lucia)', 'en_LC', 1, 0, NULL),
(183, 'English (St. Vincent & Grenadines)', 'en_VC', 1, 0, NULL),
(184, 'English (Sudan)', 'en_SD', 1, 0, NULL),
(185, 'English (Swaziland)', 'en_SZ', 1, 0, NULL),
(186, 'English (Sweden)', 'en_SE', 1, 0, NULL),
(187, 'English (Switzerland)', 'en_CH', 1, 0, NULL),
(188, 'English (Tanzania)', 'en_TZ', 1, 0, NULL),
(189, 'English (Tokelau)', 'en_TK', 1, 0, NULL),
(190, 'English (Tonga)', 'en_TO', 1, 0, NULL),
(191, 'English (Trinidad & Tobago)', 'en_TT', 1, 0, NULL),
(192, 'English (Turks & Caicos Islands)', 'en_TC', 1, 0, NULL),
(193, 'English (Tuvalu)', 'en_TV', 1, 0, NULL),
(194, 'English (U.S. Outlying Islands)', 'en_UM', 1, 0, NULL),
(195, 'English (U.S. Virgin Islands)', 'en_VI', 1, 0, NULL),
(196, 'English (Uganda)', 'en_UG', 1, 0, NULL),
(197, 'English (United Kingdom)', 'en_GB', 1, 0, NULL),
(198, 'English (United States, Computer)', 'en_US_POSIX', 1, 0, NULL),
(199, 'English (Vanuatu)', 'en_VU', 1, 0, NULL),
(200, 'English (Zambia)', 'en_ZM', 1, 0, NULL),
(201, 'English (Zimbabwe)', 'en_ZW', 1, 0, NULL),
(202, 'Estonian (Estonia) - Eesti (Eesti)', 'et_EE', 1, 0, NULL),
(203, 'Ewe (Ghana)', 'ee_GH', 1, 0, NULL),
(204, 'Ewe (Togo)', 'ee_TG', 1, 0, NULL),
(205, 'Ewondo (Cameroon)', 'ewo_CM', 1, 0, NULL),
(206, 'Faroese (Denmark)', 'fo_DK', 1, 0, NULL),
(207, 'Faroese (Faroe Islands)', 'fo_FO', 1, 0, NULL),
(208, 'Filipino (Philippines) - Filipino (Pilipinas)', 'fil_PH', 1, 0, NULL),
(209, 'Finnish (Finland) - Suomi (Suomi)', 'fi_FI', 1, 0, NULL),
(210, 'French (Algeria) - Français (Algérie)', 'fr_DZ', 1, 0, NULL),
(211, 'French (Belgium) - Français (Belgique)', 'fr_BE', 1, 0, NULL),
(212, 'French (Benin) - Français (Bénin)', 'fr_BJ', 1, 0, NULL),
(213, 'French (Burkina Faso) - Français (Burkina Faso)', 'fr_BF', 1, 0, NULL),
(214, 'French (Burundi) - Français (Burundi)', 'fr_BI', 1, 0, NULL),
(215, 'French (Cameroon) - Français (Cameroun)', 'fr_CM', 1, 0, NULL),
(216, 'French (Canada) - Français (Canada)', 'fr_CA', 1, 0, NULL),
(217, 'French (Central African Republic) - Français (République centrafricaine)', 'fr_CF', 1, 0, NULL),
(218, 'French (Chad) - Français (Tchad)', 'fr_TD', 1, 0, NULL),
(219, 'French (Comoros) - Français (Comores)', 'fr_KM', 1, 0, NULL),
(220, 'French (Congo - Brazzaville) (fr-CG) - Français (Congo-Brazzaville) (fr-CG)', 'fr_CG', 1, 0, NULL),
(221, 'French (Congo - Kinshasa) - Français (Congo-Kinshasa)', 'fr_CD', 1, 0, NULL),
(222, 'French (Côte d’Ivoire) - Français (Côte d\'Ivoire)', 'fr_CI', 1, 0, NULL),
(223, 'French (Djibouti) - Français (Djibouti)', 'fr_DJ', 1, 0, NULL),
(224, 'French (Equatorial Guinea) - Français (Guinée équatoriale)', 'fr_GQ', 1, 0, NULL),
(225, 'French (France) - France francaise)', 'fr_FR', 1, 0, NULL),
(226, 'French (French Guiana) - Français (Guyane française)', 'fr_GF', 1, 0, NULL),
(227, 'French (French Polynesia) - Français (Polynésie française)', 'fr_PF', 1, 0, NULL),
(228, 'French (Gabon) - Français (Gabon)', 'fr_GA', 1, 0, NULL),
(229, 'French (Guadeloupe) - Français (Guadeloupe)', 'fr_GP', 1, 0, NULL),
(230, 'French (Guinea) - Français (Guinée)', 'fr_GN', 1, 0, NULL),
(231, 'French (Haiti) - Français (Haïti)', 'fr_HT', 1, 0, NULL),
(232, 'French (Luxembourg) - Français (Luxembourg)', 'fr_LU', 1, 0, NULL),
(233, 'French (Madagascar) - Français (Madagascar)', 'fr_MG', 1, 0, NULL),
(234, 'French (Mali) - Français (Mali)', 'fr_ML', 1, 0, NULL),
(235, 'French (Martinique) - Français (Martinique)', 'fr_MQ', 1, 0, NULL),
(236, 'French (Mauritania) - Français (Mauritanie)', 'fr_MR', 1, 0, NULL),
(237, 'French (Mauritius) - Français (Maurice)', 'fr_MU', 1, 0, NULL),
(238, 'French (Mayotte) - Français (Mayotte)', 'fr_YT', 1, 0, NULL),
(239, 'French (Monaco) - Français (Monaco)', 'fr_MC', 1, 0, NULL),
(240, 'French (Morocco) - Français (Maroc)', 'fr_MA', 1, 0, NULL),
(241, 'French (New Caledonia) - Français (Nouvelle-Calédonie)', 'fr_NC', 1, 0, NULL),
(242, 'French (Niger) - Français (Niger)', 'fr_NE', 1, 0, NULL),
(243, 'French (Réunion) - Français (Réunion)', 'fr_RE', 1, 0, NULL),
(244, 'French (Rwanda) - Français (Rwanda)', 'fr_RW', 1, 0, NULL),
(245, 'French (Senegal) - Français (Sénégal)', 'fr_SN', 1, 0, NULL),
(246, 'French (Seychelles) - Français (Seychelles)', 'fr_SC', 1, 0, NULL),
(247, 'French (St. Barthélemy) - Français (Saint-Barthélemy)', 'fr_BL', 1, 0, NULL),
(248, 'French (St. Martin) - Français (Saint-Martin)', 'fr_MF', 1, 0, NULL),
(249, 'French (St. Pierre & Miquelon) - Français (Saint-Pierre-et-Miquelon)', 'fr_PM', 1, 0, NULL),
(250, 'French (Switzerland) - Français (Suisse)', 'fr_CH', 1, 0, NULL),
(251, 'French (Syria) - Français (Syrie)', 'fr_SY', 1, 0, NULL),
(252, 'French (Togo) - Français (Togo)', 'fr_TG', 1, 0, NULL),
(253, 'French (Tunisia) - Français (Tunisie)', 'fr_TN', 1, 0, NULL),
(254, 'French (Vanuatu) - Français (Vanuatu)', 'fr_VU', 1, 0, NULL),
(255, 'French (Wallis & Futuna) - Français (Wallis et Futuna)', 'fr_WF', 1, 0, NULL),
(256, 'Friulian (Italy)', 'fur_IT', 1, 0, NULL),
(257, 'Fulah (Cameroon)', 'ff_CM', 1, 0, NULL),
(258, 'Fulah (Guinea)', 'ff_GN', 1, 0, NULL),
(259, 'Fulah (Mauritania)', 'ff_MR', 1, 0, NULL),
(260, 'Fulah (Senegal)', 'ff_SN', 1, 0, NULL),
(261, 'Galician (Spain) - Galicia (España)', 'gl_ES', 1, 0, NULL),
(262, 'Ganda (Uganda)', 'lg_UG', 1, 0, NULL),
(263, 'Georgian (Georgia) - Georgian (Georgia)', 'ka_GE', 1, 0, NULL),
(264, 'German (Austria) - Deutsch (Österreich)', 'de_AT', 1, 0, NULL),
(265, 'German (Belgium) - Deutsch (Belgien)', 'de_BE', 1, 0, NULL),
(266, 'German (Germany) - Deutsches Deutschland)', 'de_DE', 1, 0, NULL),
(267, 'German (Italy) - Deutsch (Italien)', 'de_IT', 1, 0, NULL),
(268, 'German (Liechtenstein) - Deutsch (Liechtenstein)', 'de_LI', 1, 0, NULL),
(269, 'German (Luxembourg) - Deutsch (Luxemburg)', 'de_LU', 1, 0, NULL),
(270, 'German (Switzerland) - Deutsch (Schweiz)', 'de_CH', 1, 0, NULL),
(271, 'Greek (Cyprus) - Ελληνικά (Κύπρος)', 'el_CY', 1, 0, NULL),
(272, 'Greek (Greece) - Ελληνικά (Ελλάδα)', 'el_GR', 1, 0, NULL),
(273, 'Gujarati (India) - ગુજરાતી (ભારત)', 'gu_IN', 1, 0, NULL),
(274, 'Gusii (Kenya)', 'guz_KE', 1, 0, NULL),
(275, 'Hausa (Ghana) - Hausa (Ghana)', 'ha_GH', 1, 0, NULL),
(276, 'Hausa (Niger) - Hausa (Nijar)', 'ha_NE', 1, 0, NULL),
(277, 'Hausa (Nigeria) - Hausa (Nigeria)', 'ha_NG', 1, 0, NULL),
(278, 'Hawaiian (United States) - Hawaiian (United States)', 'haw_US', 1, 0, NULL),
(279, 'Hebrew (Israel) - עברית (ישראל)', 'he_IL', 1, 0, NULL),
(280, 'Hindi (India) - हिंदी भारत)', 'hi_IN', 1, 0, NULL),
(281, 'Hungarian (Hungary) - Magyar (Magyarország)', 'hu_HU', 1, 0, NULL),
(282, 'Icelandic (Iceland) - Icelandic (Iceland)', 'is_IS', 1, 0, NULL),
(283, 'Igbo (Nigeria) - Igbo (Nigeria)', 'ig_NG', 1, 0, NULL),
(284, 'Inari Sami (Finland)', 'smn_FI', 1, 0, NULL),
(285, 'Indonesian (Indonesia) - Indonesia (Indonesia)', 'id_ID', 1, 0, NULL),
(286, 'Irish (Ireland) - Gaeilge (Éire)', 'ga_IE', 1, 0, NULL),
(287, 'Italian (Italy) - Italiano (Italia)', 'it_IT', 1, 0, NULL),
(288, 'Italian (San Marino) - Italiano (San Marino)', 'it_SM', 1, 0, NULL),
(289, 'Italian (Switzerland) - Italiano (Svizzera)', 'it_CH', 1, 0, NULL),
(290, 'Italian (Vatican City) - Italiano (Città del Vaticano)', 'it_VA', 1, 0, NULL),
(291, 'Japanese (Japan) - 日本語（日本）', 'ja_JP', 1, 0, NULL),
(292, 'Jola-Fonyi (Senegal)', 'dyo_SN', 1, 0, NULL),
(293, 'Kabuverdianu (Cape Verde)', 'kea_CV', 1, 0, NULL),
(294, 'Kabyle (Algeria)', 'kab_DZ', 1, 0, NULL),
(295, 'Kako (Cameroon)', 'kkj_CM', 1, 0, NULL),
(296, 'Kalaallisut (Greenland)', 'kl_GL', 1, 0, NULL),
(297, 'Kalenjin (Kenya)', 'kln_KE', 1, 0, NULL),
(298, 'Kamba (Kenya)', 'kam_KE', 1, 0, NULL),
(299, 'Kannada (India) - ಕನ್ನಡ (ಭಾರತ)', 'kn_IN', 1, 0, NULL),
(300, 'Kashmiri (India)', 'ks_IN', 1, 0, NULL),
(301, 'Kazakh (Kazakhstan) - Қазақ (Қазақстан)', 'kk_KZ', 1, 0, NULL),
(302, 'Khmer (Cambodia) - ខ្មែរ (កម្ពុជា)', 'km_KH', 1, 0, NULL),
(303, 'Kikuyu (Kenya)', 'ki_KE', 1, 0, NULL),
(304, 'Kinyarwanda (Rwanda) - Kinyarwanda (Rwanda)', 'rw_RW', 1, 0, NULL),
(305, 'Konkani (India)', 'kok_IN', 1, 0, NULL),
(306, 'Korean (North Korea) - 한국어 (북한)', 'ko_KP', 1, 0, NULL),
(307, 'Korean (South Korea) - 한국어 (한국)', 'ko_KR', 1, 0, NULL),
(308, 'Koyra Chiini (Mali)', 'khq_ML', 1, 0, NULL),
(309, 'Koyraboro Senni (Mali)', 'ses_ML', 1, 0, NULL),
(310, 'Kwasio (Cameroon)', 'nmg_CM', 1, 0, NULL),
(311, 'Kyrgyz (Kyrgyzstan) - Kyrgyz (Kyrgyzstan)', 'ky_KG', 1, 0, NULL),
(312, 'Lakota (United States)', 'lkt_US', 1, 0, NULL),
(313, 'Langi (Tanzania)', 'lag_TZ', 1, 0, NULL),
(314, 'Lao (Laos) - ລາວ (ລາວ)', 'lo_LA', 1, 0, NULL),
(315, 'Latvian (Latvia) - Latviešu (Latvija)', 'lv_LV', 1, 0, NULL),
(316, 'Lingala (Angola)', 'ln_AO', 1, 0, NULL),
(317, 'Lingala (Central African Republic)', 'ln_CF', 1, 0, NULL),
(318, 'Lingala (Congo - Brazzaville)', 'ln_CG', 1, 0, NULL),
(319, 'Lingala (Congo - Kinshasa)', 'ln_CD', 1, 0, NULL),
(320, 'Lithuanian (Lithuania) - Lietuvių (Lietuva)', 'lt_LT', 1, 0, NULL),
(321, 'Low German (Germany)', 'nds_DE', 1, 0, NULL),
(322, 'Low German (Netherlands)', 'nds_NL', 1, 0, NULL),
(323, 'Lower Sorbian (Germany)', 'dsb_DE', 1, 0, NULL),
(324, 'Luba-Katanga (Congo - Kinshasa)', 'lu_CD', 1, 0, NULL),
(325, 'Luo (Kenya)', 'luo_KE', 1, 0, NULL),
(326, 'Luxembourgish (Luxembourg) - Lëtzebuergesch (Lëtzebuerg)', 'lb_LU', 1, 0, NULL),
(327, 'Luyia (Kenya)', 'luy_KE', 1, 0, NULL),
(328, 'Macedonian (Macedonia) - Македонски (Macedonia)', 'mk_MK', 1, 0, NULL),
(329, 'Machame (Tanzania)', 'jmc_TZ', 1, 0, NULL),
(330, 'Makhuwa-Meetto (Mozambique)', 'mgh_MZ', 1, 0, NULL),
(331, 'Makonde (Tanzania)', 'kde_TZ', 1, 0, NULL),
(332, 'Malagasy (Madagascar) - Malagasy (Madagascar)', 'mg_MG', 1, 0, NULL),
(333, 'Malay (Brunei) - Melayu (Brunei)', 'ms_BN', 1, 0, NULL),
(334, 'Malay (Malaysia) - Melayu (Malaysia)', 'ms_MY', 1, 0, NULL),
(335, 'Malay (Singapore) - Melayu (Singapura)', 'ms_SG', 1, 0, NULL),
(336, 'Malayalam (India) - മലയാളം (ഇന്ത്യ)', 'ml_IN', 1, 0, NULL),
(337, 'Maltese (Malta) - Malti (Malta)', 'mt_MT', 1, 0, NULL),
(338, 'Manx (Isle of Man)', 'gv_IM', 1, 0, NULL),
(339, 'Marathi (India) - मराठी (भारत)', 'mr_IN', 1, 0, NULL),
(340, 'Masai (Kenya)', 'mas_KE', 1, 0, NULL),
(341, 'Masai (Tanzania)', 'mas_TZ', 1, 0, NULL),
(342, 'Mazanderani (Iran)', 'mzn_IR', 1, 0, NULL),
(343, 'Meru (Kenya)', 'mer_KE', 1, 0, NULL),
(344, 'Metaʼ (Cameroon)', 'mgo_CM', 1, 0, NULL),
(345, 'Mongolian (Mongolia) - Монгол улсын (Монгол)', 'mn_MN', 1, 0, NULL),
(346, 'Morisyen (Mauritius)', 'mfe_MU', 1, 0, NULL),
(347, 'Mundang (Cameroon)', 'mua_CM', 1, 0, NULL),
(348, 'Nama (Namibia)', 'naq_NA', 1, 0, NULL),
(349, 'Nepali (India) - नेपाली (भारत)', 'ne_IN', 1, 0, NULL),
(350, 'Nepali (Nepal) - नेपाली (नेपाल)', 'ne_NP', 1, 0, NULL),
(351, 'Ngiemboon (Cameroon)', 'nnh_CM', 1, 0, NULL),
(352, 'Ngomba (Cameroon)', 'jgo_CM', 1, 0, NULL),
(353, 'North Ndebele (Zimbabwe)', 'nd_ZW', 1, 0, NULL),
(354, 'Northern Luri (Iran)', 'lrc_IR', 1, 0, NULL),
(355, 'Northern Luri (Iraq)', 'lrc_IQ', 1, 0, NULL),
(356, 'Northern Sami (Finland)', 'se_FI', 1, 0, NULL),
(357, 'Northern Sami (Norway)', 'se_NO', 1, 0, NULL),
(358, 'Northern Sami (Sweden)', 'se_SE', 1, 0, NULL),
(359, 'Norwegian Bokmål (Norway) - Norsk bokmål (Norge)', 'nb_NO', 1, 0, NULL),
(360, 'Norwegian Bokmål (Svalbard & Jan Mayen) - Norsk bokmål (Svalbard og Jan Mayen)', 'nb_SJ', 1, 0, NULL),
(361, 'Norwegian Nynorsk (Norway)', 'nn_NO', 1, 0, NULL),
(362, 'Nuer (South Sudan)', 'nus_SS', 1, 0, NULL),
(363, 'Nyankole (Uganda)', 'nyn_UG', 1, 0, NULL),
(364, 'Odia (India) - ଓଡ଼ିଆ (ଭାରତ)', 'or_IN', 1, 0, NULL),
(365, 'Oromo (Ethiopia)', 'om_ET', 1, 0, NULL),
(366, 'Oromo (Kenya)', 'om_KE', 1, 0, NULL),
(367, 'Ossetic (Georgia)', 'os_GE', 1, 0, NULL),
(368, 'Ossetic (Russia)', 'os_RU', 1, 0, NULL),
(369, 'Pashto (Afghanistan) - پښتو (افغانستان)', 'ps_AF', 1, 0, NULL),
(370, 'Persian (Afghanistan) - فارسی (افغانستان)', 'fa_AF', 1, 0, NULL),
(371, 'Persian (Iran) - فارسی (ایران)', 'fa_IR', 1, 0, NULL),
(372, 'Polish (Poland) - Polski (Polska)', 'pl_PL', 1, 0, NULL),
(373, 'Portuguese (Angola) - Português (Angola)', 'pt_AO', 1, 0, NULL),
(374, 'Portuguese (Brazil) - Português (Brasil)', 'pt_BR', 1, 0, NULL),
(375, 'Portuguese (Cape Verde) - Português (Cabo Verde)', 'pt_CV', 1, 0, NULL),
(376, 'Portuguese (Equatorial Guinea) - Português (Guiné Equatorial)', 'pt_GQ', 1, 0, NULL),
(377, 'Portuguese (Guinea-Bissau) - Português (Guiné-Bissau)', 'pt_GW', 1, 0, NULL),
(378, 'Portuguese (Luxembourg) - Português (Luxemburgo)', 'pt_LU', 1, 0, NULL),
(379, 'Portuguese (Macau SAR China) - Português (Macau SAR China)', 'pt_MO', 1, 0, NULL),
(380, 'Portuguese (Mozambique) - Português (Moçambique)', 'pt_MZ', 1, 0, NULL),
(381, 'Portuguese (Portugal) - Português (Portugal)', 'pt_PT', 1, 0, NULL),
(382, 'Portuguese (São Tomé & Príncipe) - Português (São Tomé e Príncipe)', 'pt_ST', 1, 0, NULL),
(383, 'Portuguese (Switzerland) - Português (Suíça)', 'pt_CH', 1, 0, NULL),
(384, 'Portuguese (Timor-Leste) - Português (Timor-Leste)', 'pt_TL', 1, 0, NULL),
(385, 'Punjabi (Arabic, Pakistan) - ਪੰਜਾਬੀ (ਅਰਬੀ, ਪਾਕਿਸਤਾਨ)', 'pa_Arab_PK', 1, 0, NULL),
(386, 'Punjabi (Gurmukhi, India) - ਪੰਜਾਬੀ (ਗੁਰਮੁਖੀ, ਭਾਰਤ)', 'pa_Guru_IN', 1, 0, NULL),
(387, 'Quechua (Bolivia)', 'qu_BO', 1, 0, NULL),
(388, 'Quechua (Ecuador)', 'qu_EC', 1, 0, NULL),
(389, 'Quechua (Peru)', 'qu_PE', 1, 0, NULL),
(390, 'Romanian (Moldova) - Română (Moldova)', 'ro_MD', 1, 0, NULL),
(391, 'Romanian (Romania) - Română (România)', 'ro_RO', 1, 0, NULL),
(392, 'Romansh (Switzerland)', 'rm_CH', 1, 0, NULL),
(393, 'Rombo (Tanzania)', 'rof_TZ', 1, 0, NULL),
(394, 'Rundi (Burundi)', 'rn_BI', 1, 0, NULL),
(395, 'Russian (Belarus) - России (Беларусь)', 'ru_BY', 1, 0, NULL),
(396, 'Russian (Kazakhstan) - России (Казахстан)', 'ru_KZ', 1, 0, NULL),
(397, 'Russian (Kyrgyzstan) - России (Кыргызстан)', 'ru_KG', 1, 0, NULL),
(398, 'Russian (Moldova) - России (Молдова)', 'ru_MD', 1, 0, NULL),
(399, 'Russian (Russia) - России (Россия)', 'ru_RU', 1, 0, NULL),
(400, 'Russian (Ukraine) - России (Украина)', 'ru_UA', 1, 0, NULL),
(401, 'Rwa (Tanzania)', 'rwk_TZ', 1, 0, NULL),
(402, 'Sakha (Russia)', 'sah_RU', 1, 0, NULL),
(403, 'Samburu (Kenya)', 'saq_KE', 1, 0, NULL),
(404, 'Sango (Central African Republic)', 'sg_CF', 1, 0, NULL),
(405, 'Sangu (Tanzania)', 'sbp_TZ', 1, 0, NULL),
(406, 'Scottish Gaelic (United Kingdom) - Gàidhlig na h-Alba (An Rìoghachd Aonaichte)', 'gd_GB', 1, 0, NULL),
(407, 'Sena (Mozambique)', 'seh_MZ', 1, 0, NULL),
(408, 'Serbian (Cyrillic, Bosnia & Herzegovina) - Српски језик (Ћирилица, Босна и Херцеговина)', 'sr_Cyrl_BA', 1, 0, NULL),
(409, 'Serbian (Cyrillic, Montenegro) - Српски језик (Ћирилица, Црна Гора)', 'sr_Cyrl_ME', 1, 0, NULL),
(410, 'Serbian (Cyrillic, Serbia) - Српски језик (Ћирилица, Србија)', 'sr_Cyrl_RS', 1, 0, NULL),
(411, 'Serbian (Latin, Bosnia & Herzegovina) - Српски (Ћирилица, Босна и Херцеговина)', 'sr_Latn_BA', 1, 0, NULL),
(412, 'Serbian (Latin, Montenegro) - Српски (латински, Црна Гора)', 'sr_Latn_ME', 1, 0, NULL),
(413, 'Serbian (Latin, Serbia) - Српски (латински, Србија)', 'sr_Latn_RS', 1, 0, NULL),
(414, 'Shambala (Tanzania)', 'ksb_TZ', 1, 0, NULL),
(415, 'Shona (Zimbabwe) - Shona (Zimbabwe)', 'sn_ZW', 1, 0, NULL),
(416, 'Sichuan Yi (China)', 'ii_CN', 1, 0, NULL),
(417, 'Sinhala (Sri Lanka) - සිංහල (ශ්‍රී ලංකාව)', 'si_LK', 1, 0, NULL),
(418, 'Slovak (Slovakia) - Slovenskú (Slovensko)', 'sk_SK', 1, 0, NULL),
(419, 'Slovenian (Slovenia) - Slovensko (Slovenija)', 'sl_SI', 1, 0, NULL),
(420, 'Soga (Uganda)', 'xog_UG', 1, 0, NULL),
(421, 'Somali (Djibouti) - Soomaali (Jabuuti)', 'so_DJ', 1, 0, NULL),
(422, 'Somali (Ethiopia) - Soomaali (Itoobiya)', 'so_ET', 1, 0, NULL),
(423, 'Somali (Kenya) - Soomaali (Kenya)', 'so_KE', 1, 0, NULL),
(424, 'Somali (Somalia) - Soomaali (Soomaaliya)', 'so_SO', 1, 0, NULL),
(425, 'Spanish (Argentina) - Español (Argentina)', 'es_AR', 1, 0, NULL),
(426, 'Spanish (Belize) - Español (Belice)', 'es_BZ', 1, 0, NULL),
(427, 'Spanish (Bolivia) - Español (Bolivia)', 'es_BO', 1, 0, NULL),
(428, 'Spanish (Brazil) - Español (Brasil)', 'es_BR', 1, 0, NULL),
(429, 'Spanish (Chile) - Español (Chile)', 'es_CL', 1, 0, NULL),
(430, 'Spanish (Colombia) - Español (Colombia)', 'es_CO', 1, 0, NULL),
(431, 'Spanish (Cuba) - Español (Cuba)', 'es_CU', 1, 0, NULL),
(432, 'Spanish (Dominican Republic) - Española (República Dominicana)', 'es_DO', 1, 0, NULL),
(433, 'Spanish (Ecuador) - Español (Ecuador)', 'es_EC', 1, 0, NULL),
(434, 'Spanish (El Salvador) - Español (El Salvador)', 'es_SV', 1, 0, NULL),
(435, 'Spanish (Equatorial Guinea) - Español (Guinea Ecuatorial)', 'es_GQ', 1, 0, NULL),
(436, 'Spanish (Guatemala) - Español (Guatemala)', 'es_GT', 1, 0, NULL),
(437, 'Spanish (Honduras) - Español (Honduras)', 'es_HN', 1, 0, NULL),
(438, 'Spanish (Mexico) - Español (México)', 'es_MX', 1, 0, NULL),
(439, 'Spanish (Nicaragua) - Español (Nicaragua)', 'es_NI', 1, 0, NULL),
(440, 'Spanish (Panama) - Español (Panamá)', 'es_PA', 1, 0, NULL),
(441, 'Spanish (Paraguay) - Español (Paraguay)', 'es_PY', 1, 0, NULL),
(442, 'Spanish (Peru) - Español (Perú)', 'es_PE', 1, 0, NULL),
(443, 'Spanish (Philippines) - Español (Filipinas)', 'es_PH', 1, 0, NULL),
(444, 'Spanish (Puerto Rico) - Español (Puerto Rico)', 'es_PR', 1, 0, NULL),
(445, 'Spanish (Spain) - Español (España)', 'es_ES', 1, 0, NULL),
(446, 'Spanish (United States) - Español (Estados Unidos)', 'es_US', 1, 0, NULL),
(447, 'Spanish (Uruguay) - Español (Uruguay)', 'es_UY', 1, 0, NULL),
(448, 'Spanish (Venezuela) - Español (Venezuela)', 'es_VE', 1, 0, NULL),
(449, 'Standard Moroccan Tamazight (Morocco)', 'zgh_MA', 1, 0, NULL),
(450, 'Swahili (Congo - Kinshasa) - Kiswahili (Congo - Kinshasa)', 'sw_CD', 1, 0, NULL),
(451, 'Swahili (Kenya) - Kiswahili (Kenya)', 'sw_KE', 1, 0, NULL),
(452, 'Swahili (Tanzania) - Kiswahili (Tanzania)', 'sw_TZ', 1, 0, NULL),
(453, 'Swahili (Uganda) - Kiswahili (Uganda)', 'sw_UG', 1, 0, NULL),
(454, 'Swedish (Åland Islands) - Svenska (Åland)', 'sv_AX', 1, 0, NULL),
(455, 'Swedish (Finland) - Svenska (Finland)', 'sv_FI', 1, 0, NULL),
(456, 'Swedish (Sweden) - Svenska (Sverige)', 'sv_SE', 1, 0, NULL),
(457, 'Swiss German (France)', 'gsw_FR', 1, 0, NULL),
(458, 'Swiss German (Liechtenstein)', 'gsw_LI', 1, 0, NULL),
(459, 'Swiss German (Switzerland)', 'gsw_CH', 1, 0, NULL),
(460, 'Tachelhit (Latin, Morocco)', 'shi_Latn_MA', 1, 0, NULL),
(461, 'Tachelhit (Tifinagh, Morocco)', 'shi_Tfng_MA', 1, 0, NULL),
(462, 'Taita (Kenya)', 'dav_KE', 1, 0, NULL),
(463, 'Tajik (Tajikistan) - Тоҷикистон (Тоҷикистон)', 'tg_TJ', 1, 0, NULL),
(464, 'Tamil (India) - தமிழ் (இந்தியா)', 'ta_IN', 1, 0, NULL),
(465, 'Tamil (Malaysia) - தமிழ் (மலேஷியா)', 'ta_MY', 1, 0, NULL),
(466, 'Tamil (Singapore) - தமிழ் (சிங்கப்பூர்)', 'ta_SG', 1, 0, NULL),
(467, 'Tamil (Sri Lanka) - தமிழ் (இலங்கை)', 'ta_LK', 1, 0, NULL),
(468, 'Tasawaq (Niger)', 'twq_NE', 1, 0, NULL),
(469, 'Tatar (Russia) - Татар (Россия)', 'tt_RU', 1, 0, NULL),
(470, 'Telugu (India) - తెలుగు (భారతదేశం)', 'te_IN', 1, 0, NULL),
(471, 'Teso (Kenya)', 'teo_KE', 1, 0, NULL),
(472, 'Teso (Uganda)', 'teo_UG', 1, 0, NULL),
(473, 'Thai (Thailand) - ไทย (ไทยแลนด์)', 'th_TH', 1, 0, NULL),
(474, 'Tibetan (China)', 'bo_CN', 1, 0, NULL),
(475, 'Tibetan (India)', 'bo_IN', 1, 0, NULL),
(476, 'Tigrinya (Eritrea)', 'ti_ER', 1, 0, NULL),
(477, 'Tigrinya (Ethiopia)', 'ti_ET', 1, 0, NULL),
(478, 'Tongan (Tonga)', 'to_TO', 1, 0, NULL),
(479, 'Turkish (Cyprus) - Türk (Kıbrıs)', 'tr_CY', 1, 0, NULL),
(480, 'Turkish (Turkey) - Türk (Türkiye)', 'tr_TR', 1, 0, NULL),
(481, 'Ukrainian (Ukraine) - Український (Україна)', 'uk_UA', 1, 0, NULL),
(482, 'Upper Sorbian (Germany)', 'hsb_DE', 1, 0, NULL),
(483, 'Urdu (India) - اردو (بھارت)', 'ur_IN', 1, 0, NULL),
(484, 'Urdu (Pakistan) - اردو (پاکستان)', 'ur_PK', 1, 0, NULL),
(485, 'Uyghur (China) - ئۇيغۇر (جۇڭگو)', 'ug_CN', 1, 0, NULL),
(486, 'Uzbek (Arabic, Afghanistan) - O\'zbekiston (arab, Afg\'oniston)', 'uz_Arab_AF', 1, 0, NULL),
(487, 'Uzbek (Cyrillic, Uzbekistan) - O\'zbek (kirill, O\'zbekiston)', 'uz_Cyrl_UZ', 1, 0, NULL),
(488, 'Uzbek (Latin, Uzbekistan) - O\'zbek (Lotin, O\'zbekiston)', 'uz_Latn_UZ', 1, 0, NULL),
(489, 'Vai (Latin, Liberia)', 'vai_Latn_LR', 1, 0, NULL),
(490, 'Vai (Vai, Liberia)', 'vai_Vaii_LR', 1, 0, NULL),
(491, 'Vietnamese (Vietnam) - Việt (Việt Nam)', 'vi_VN', 1, 0, NULL),
(492, 'Vunjo (Tanzania)', 'vun_TZ', 1, 0, NULL),
(493, 'Walser (Switzerland)', 'wae_CH', 1, 0, NULL),
(494, 'Welsh (United Kingdom) - Cymraeg (Welsh)', 'cy_GB', 1, 0, NULL),
(495, 'Western Frisian (Netherlands) - Western Frysk (Nederland)', 'fy_NL', 1, 0, NULL),
(496, 'Wolof (Senegal)', 'wo_SN', 1, 0, NULL),
(497, 'Yangben (Cameroon)', 'yav_CM', 1, 0, NULL),
(498, 'Yoruba (Benin) - Yorùbá (Benin)', 'yo_BJ', 1, 0, NULL),
(499, 'Yoruba (Nigeria) - Yorùbá (Nigeria)', 'yo_NG', 1, 0, NULL),
(500, 'Zarma (Niger)', 'dje_NE', 1, 0, NULL),
(501, 'Zulu (South Africa) - Zulu (South Africa)', 'zu_ZA', 1, 0, NULL);

-- --------------------------------------------------------
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
