-----------------------------------
-- Area: Upper Jeuno
--  NPC: Constance
-- Involved in Quests: Save the Clock Tower
-- !pos -48 0 4 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1) then
        local a = player:getCharVar("saveTheClockTowerNPCz1") -- NPC Part1
        if (a == 0 or (a ~= 8 and a ~= 9 and a ~= 10 and a ~= 12 and a ~= 24 and a ~= 11 and a ~= 28 and a ~= 13 and
           a ~= 26 and a ~= 14 and a ~= 25 and a ~= 15 and a ~= 27 and a ~= 29 and a ~= 30 and a ~= 31)) then
            player:startEvent(180, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(90)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 180) then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz1", 8)
    end
end
