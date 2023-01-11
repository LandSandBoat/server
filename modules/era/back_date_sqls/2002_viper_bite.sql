-- Sep. 12th, 2002: "The skill levels required to learn Viper Bite and Gust Slash were switched."
-- https://www.bg-wiki.com/ffxi/The_History_of_Final_Fantasy_XI/2002
-- (This reverses the change)
REPLACE INTO `weapon_skills` (`weaponskillid`, `name`, `jobs`, `type`, `skilllevel`, `element`, `animation`, `animationTime`, `range`, `aoe`, `primary_sc`, `secondary_sc`, `tertiary_sc`, `main_only`, `unlock_id`) VALUES
    (17,'viper_bite',0x00000000020200000002020002000000000002000000,2,40,0,32,2000,5,1,4,0,0,0,0),
    (19,'gust_slash',0x02000002020202020202020202020200020202020000,2,100,16,34,2000,15,1,6,0,0,0,0);
