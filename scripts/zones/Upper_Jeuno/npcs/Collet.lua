-----------------------------------
-- Area: Upper Jeuno
--  NPC: Collet
-- Involved in Quests: A Clock Most Delicate, Save the Clock Tower
-- !pos -44 0 107 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1) then
        local a = player:getCharVar("saveTheClockTowerNPCz1") -- NPC zone1
        if (a == 0 or (a ~= 2 and a ~= 3 and a ~= 6 and a ~= 10 and a ~= 18 and a ~= 7 and a ~= 26 and a ~= 11 and
           a ~= 22 and a ~= 14 and a ~= 19 and a ~= 15 and a ~= 23 and a ~= 27 and a ~= 30 and a ~= 31)) then
            player:startEvent(115, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
end

function onTrigger(player, npc)
    if (player:getFameLevel(JEUNO) >= 5 and aClockMostdelicate == QUEST_AVAILABLE and player:getCharVar("aClockMostdelicateVar") == 0) then
        player:startEvent(112)
    elseif (player:getCharVar("saveTheClockTowerVar") >= 1) then
        player:startEvent(164)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_CLOCKMASTER) == QUEST_COMPLETED) then
        player:startEvent(163)
    else
        player:startEvent(114)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 112) then
        player:setCharVar("aClockMostdelicateVar", 1)
    elseif (csid == 115) then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz1", 2)
    end
end
