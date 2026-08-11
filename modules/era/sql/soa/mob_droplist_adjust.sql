-----------------------------------
-- Mob drop list item adjustment module
-- This module removes or adds items for the SoA era
-----------------------------------

-- Replace Crier's Gaiters with Herald's Gaiters from Tiamat
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
UPDATE mob_droplist SET itemId = 15322 WHERE itemId = 27456 and dropId = 2416;
