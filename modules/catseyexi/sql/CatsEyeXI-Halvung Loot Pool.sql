#USE xidb; #For default installs
USE tpzdb; #Or change to your database name
SET @ItemId = 8801;
DELETE FROM `mob_droplist` WHERE `dropId` = 2474 AND `itemId` = @ItemId;
DELETE FROM `mob_droplist` WHERE `dropId` = 2477 AND `itemId` = @ItemId;
DELETE FROM `mob_droplist` WHERE `dropId` = 2478 AND `itemId` = @ItemId;
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (2474,0,0,1000,@ItemId,80);
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (2477,0,0,1000,@ItemId,80);
INSERT `mob_droplist` (`dropId`,`dropType`,`groupId`,`groupRate`,`itemId`,`itemRate`) VALUES (2478,0,0,1000,@ItemId,80);