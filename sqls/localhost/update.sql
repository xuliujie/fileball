ALTER TABLE `social_auth_steamuser`
MODIFY COLUMN `tradeurl`  varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `is_staff`;

ALTER TABLE `social_auth_steamuser`
ADD COLUMN `amount`  float NULL DEFAULT 0.0 AFTER `can_chat`;

