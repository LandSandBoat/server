#USE xidb; # For default installs
USE tpzdb; #Or change to your database name
######
## Restore pre-RMT drops
######
UPDATE `mob_droplist` SET `itemId`= 13056 WHERE `dropId`=165 AND `itemId`=15515;
UPDATE `mob_droplist` SET `itemId`= 17187 WHERE `dropId`=738 AND `itemId`=18714;
UPDATE `mob_droplist` SET `itemId`= 15899 WHERE `dropId`=1448 AND `itemId`=13189;
UPDATE `mob_droplist` SET `itemId`= 13189 WHERE `dropId`=1449 AND `itemId`=15899;
UPDATE `mob_droplist` SET `itemId`= 13014 WHERE `dropId`=1504 AND `itemId`=15351;
UPDATE `mob_droplist` SET `itemId`= 17440 WHERE `dropId`=1536 AND `itemId`=18852;
UPDATE `mob_droplist` SET `itemId`= 13952 WHERE `dropId`=1652 AND `itemId`=14986;
UPDATE `mob_droplist` SET `itemId`= 13054 WHERE `dropId`=2069 AND `itemId`=15737;
UPDATE `mob_droplist` SET `itemId`= 14080 WHERE `dropId`=2255 AND `itemId`=15736;
UPDATE `mob_droplist` SET `itemId`= 12486 WHERE `dropId`=2536 AND `itemId`=15224;
UPDATE `mob_droplist` SET `itemId`= 17472 WHERE `dropId`=2645 AND `itemId`=18752;

######
## Update Angel skin drop-rates
######
DELETE FROM `mob_droplist` WHERE dropId = 5000 AND itemId= 1312; #Remove rookie mistake
DELETE FROM `mob_droplist` WHERE dropId = 4000 AND itemId= 1312; #Remove from Nostokulshedra
DELETE FROM `mob_droplist` WHERE dropId = 456 AND itemId= 1312; #Remove from Chary
INSERT `mob_droplist` VALUES(4000,0,1,1000,1312,10); #piece_of_angel_skin Nostokulshedra
INSERT `mob_droplist` VALUES(456,0,1,1000,1312,70); #piece_of_angel_skin Charybdis
UPDATE `mob_droplist` SET itemRate = 70 WHERE dropId = 2196 AND itemId = 1312; #Update Seiryu droprate
UPDATE mob_groups SET dropId = 4000 WHERE zoneId = 54 AND groupId = 52 AND `name` = 'Nostokulshedra'; #Add drop to this thing