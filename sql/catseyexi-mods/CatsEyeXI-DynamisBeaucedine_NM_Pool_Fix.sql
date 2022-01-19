#USE xidb; #For default installs
USE tpzdb; #Or change to your database name
SET @ItemId =3357;
DELETE FROM `mob_droplist` WHERE `dropId` = 176 AND `itemId` = @ItemId;
DELETE FROM `mob_droplist` WHERE `dropId` = 261 AND `itemId` = @ItemId;
DELETE FROM `mob_droplist` WHERE `dropId` = 265 AND `itemId` = @ItemId;
DELETE FROM `mob_droplist` WHERE `dropId` = 493 AND `itemId` = @ItemId;
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (176,0,0,1000,@ItemId,260);
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (261,0,0,1000,@ItemId,260);
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (265,0,0,1000,@ItemId,260);
--INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (496,0,0,1000,@ItemId,260);