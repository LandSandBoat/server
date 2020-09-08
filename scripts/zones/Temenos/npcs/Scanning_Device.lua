-----------------------------------
-- Area: Temenos
-- NPC:  Scanning_Device
-- !pos 586 0 66 37
-----------------------------------
require("scripts/globals/limbus")

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player, npc, trade)
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(121, 511)
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player, csid, option)
    local time = 0
    switch (option): caseof {
        [1] = function (x) time = player:getBattlefieldTimeLeft(1); end, -- Northern Tower
        [2] = function (x) time = player:getBattlefieldTimeLeft(2); end, -- Eastern Tower
        [3] = function (x) time = player:getBattlefieldTimeLeft(3); end, -- Western Tower
        [4] = function (x) time = player:getBattlefieldTimeLeft(4); end, -- Central 4th
        [5] = function (x) time = player:getBattlefieldTimeLeft(5); end, -- Central 3rd
        [6] = function (x) time = player:getBattlefieldTimeLeft(6); end, -- Central 2nd
        [7] = function (x) time = player:getBattlefieldTimeLeft(7); end, -- Central 1st
        [8] = function (x) time = player:getBattlefieldTimeLeft(8); end, -- Central Basement
    }
    player:updateEvent(0, time, 0, 0, 0, 0, 0, 0)
end

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player, csid, option)
end
