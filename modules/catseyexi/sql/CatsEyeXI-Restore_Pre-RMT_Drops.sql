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
