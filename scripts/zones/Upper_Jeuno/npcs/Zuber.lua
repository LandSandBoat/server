-----------------------------------
-- Area: Upper Jeuno
--  NPC: Zuber
-- Involved in Quests: Save the Clock Tower
-- !pos -106 0 90 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1) then
        local a = player:getCharVar("saveTheClockTowerNPCz2") -- NPC Zone2
        if (a == 0 or (a ~= 64 and a ~= 96 and a ~= 192 and a ~= 320 and a ~= 576 and a ~= 224 and a ~= 832 and a ~= 352 and
           a ~= 704 and a ~= 448 and a ~= 608 and a ~= 480 and a ~= 736 and a ~= 864 and a ~= 960 and a ~= 992)) then
            player:startEvent(126, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(125)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 126) then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz2", 64)
    end
end
