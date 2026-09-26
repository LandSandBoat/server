-- Changes Tonosama Rice Ball's NQ yield from 2 to 4.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
UPDATE `synth_recipes` SET `ResultQty` = 2 WHERE `ID` = 74523;
