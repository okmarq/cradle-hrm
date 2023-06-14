UPDATE `ohrm_menu_item` SET `menu_title` = 'Personal Info Management' WHERE `ohrm_menu_item`.`id` = 30;

UPDATE `ohrm_i18n_translate` SET `value` = 'Personal Info Management' WHERE `ohrm_i18n_translate`.`id` = 1594;

UPDATE `ohrm_i18n_lang_string` SET `unit_id` = 'pim', `value` = 'Employee Information Management' WHERE `ohrm_i18n_lang_string`.`id` = 271;

UPDATE `ohrm_i18n_group` SET `name` = 'pim', `title` = 'Employee Information Management' WHERE `ohrm_i18n_group`.`id` = 3;

UPDATE `ohrm_module` SET `name` = 'pim', `display_name` = 'Employee Information Management' WHERE `ohrm_module`.`id` = 3;

UPDATE `hs_hr_module` SET `name` = 'Employee Information Management' WHERE `hs_hr_module`.`mod_id` = 'MOD002';

DELETE FROM `ohrm_menu_item` WHERE `ohrm_menu_item`.`id` = 101;

UPDATE `ohrm_report` SET `name` = 'Employee Info Management Report' WHERE `ohrm_report`.`report_id` = 5;

ALTER TABLE `ohrm_user` ADD UNIQUE(`user_name`);

UPDATE `ohrm_menu_item` SET `order_hint` = '100' WHERE `ohrm_menu_item`.`id` = 82;
UPDATE `ohrm_menu_item` SET `order_hint` = '200' WHERE `ohrm_menu_item`.`id` = 1;
UPDATE `ohrm_menu_item` SET `order_hint` = '300' WHERE `ohrm_menu_item`.`id` = 30;
UPDATE `ohrm_menu_item` SET `order_hint` = '400' WHERE `ohrm_menu_item`.`id` = 41;
UPDATE `ohrm_menu_item` SET `order_hint` = '500' WHERE `ohrm_menu_item`.`id` = 52;
UPDATE `ohrm_menu_item` SET `order_hint` = '600' WHERE `ohrm_menu_item`.`id` = 65;
UPDATE `ohrm_menu_item` SET `order_hint` = '800' WHERE `ohrm_menu_item`.`id` = 83;
UPDATE `ohrm_menu_item` SET `order_hint` = '700' WHERE `ohrm_menu_item`.`id` = 40;

-- REVERT
UPDATE `ohrm_menu_item` SET `menu_title` = 'PIM' WHERE `ohrm_menu_item`.`id` = 30;

UPDATE `ohrm_i18n_translate` SET `value` = 'PIM' WHERE `ohrm_i18n_translate`.`id` = 1594;

UPDATE `ohrm_i18n_lang_string` SET `unit_id` = 'pim', `value` = 'PIM' WHERE `ohrm_i18n_lang_string`.`id` = 271;

UPDATE `ohrm_i18n_group` SET `name` = 'pim', `title` = 'PIM' WHERE `ohrm_i18n_group`.`id` = 3;

UPDATE `ohrm_module` SET `name` = 'pim', `display_name` = 'PIM' WHERE `ohrm_module`.`id` = 3;

UPDATE `hs_hr_module` SET `name` = 'PIM' WHERE `hs_hr_module`.`mod_id` = 'MOD002';

INSERT INTO `ohrm_menu_item` SET `id` = '101', `menu_title` = 'Buzz', `screen_id` = '123', `level` = '1', `order_hint` = '1500', `status` = '1', `additional_params` = '{\"icon\":\"buzz\"}';

UPDATE `ohrm_report` SET `name` = 'PIM Sample Report' WHERE `ohrm_report`.`report_id` = 5;