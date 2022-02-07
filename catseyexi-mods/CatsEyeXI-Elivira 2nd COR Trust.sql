#USE xidb; #For default installs
USE tpzdb; #Or change to your database name
#poolid;name;mJob;sJob;
#1198;Elivira;11;11;
#5941;elivira;11;1;
UPDATE mob_pools SET mJob = 17 WHERE poolid =1198 AND `name` = 'Elivira';
UPDATE mob_pools SET mJob = 17 WHERE poolid = 5941 AND `name` = 'elivira';