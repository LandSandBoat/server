-- Changes the skill requirement to repair Lu Shangs from 70 to 80.
-- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
UPDATE `synth_recipes` SET `Wood` = 80 WHERE `ID` = 3049;
