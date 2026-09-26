-- Changes Fuma Shuriken synthesis yields back to 3, 6, 9, 12.
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
UPDATE `synth_recipes` SET `ResultQty` = 3, `ResultHQ1Qty` = 6, `ResultHQ2Qty` = 9, `ResultHQ3Qty` = 12 WHERE `ID` = 14017;
