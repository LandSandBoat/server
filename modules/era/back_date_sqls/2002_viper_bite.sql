-- Sep. 12th, 2002: "The skill levels required to learn Viper Bite and Gust Slash were switched."
-- https://www.bg-wiki.com/ffxi/The_History_of_Final_Fantasy_XI/2002
-- (This reverses the change, so Viper Bite is learned earlier)
UPDATE `weapon_skills` SET skilllevel = 40 WHERE name = 'viper_bite';
UPDATE `weapon_skills` SET skilllevel = 100 WHERE name = 'gust_slash';
