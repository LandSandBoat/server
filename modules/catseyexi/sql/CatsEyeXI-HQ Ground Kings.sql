# CatsEyeXI 2021-08-19
# Buff ground HQ Kings

#USE xidb; # For defaul installs
USE tpzdb; #Or change to your database name
UPDATE mob_groups SET HP=90000 WHERE groupid = 6 AND `name` = 'Nidhogg';
UPDATE mob_groups SET HP=90000 WHERE groupid = 7 AND `name` = 'Aspidochelone';
UPDATE mob_groups SET HP=90000 WHERE groupid = 10 AND `name` = 'King_Behemoth';