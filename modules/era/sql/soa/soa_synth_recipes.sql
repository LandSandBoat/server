-- Changes Fuma Shuriken synthesis yields back to 3, 6, 9, 12.
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
UPDATE `synth_recipes` SET `ResultQty` = 3, `ResultHQ1Qty` = 6, `ResultHQ2Qty` = 9, `ResultHQ3Qty` = 12 WHERE `ID` = 14017;

-- Changes Shall Shell and Istiridye synthesis results back to Pebble (NQ), Pearl (HQ1), Black Pearl (HQ2/HQ3).
-- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-%28JST%29-Version-Update
UPDATE `synth_recipes` SET `Result` = 17296, `ResultHQ1` = 792, `ResultName` = 'Pebble' WHERE `ID` = 50514; -- Shall Shell
UPDATE `synth_recipes` SET `Result` = 17296, `ResultHQ1` = 792, `ResultName` = 'Pebble' WHERE `ID` = 50516; -- Istiridye
