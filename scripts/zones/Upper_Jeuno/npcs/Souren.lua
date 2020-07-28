-----------------------------------
-- Area: Upper Jeuno
--  NPC: Souren
-- Involved in Quests: Save the Clock Tower
-- !pos -51 0 4 244
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1) then
        local a = player:getCharVar("saveTheClockTowerNPCz1") -- NPC Part1
        if (a == 0 or (a ~= 16 and a ~= 17 and a ~= 18 and a ~= 20 and a ~= 24 and a ~= 19 and a ~= 28 and a ~= 21 and
           a ~= 26 and a ~= 22 and a ~= 25 and a ~= 23 and a ~= 27 and a ~= 29 and a ~= 30 and a ~= 31)) then
            player:startEvent(182, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) == QUEST_ACCEPTED) then
        player:startEvent(120)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SAVE_THE_CLOCK_TOWER) == QUEST_COMPLETED) then
        player:startEvent(181)
    else
        player:startEvent(88)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 182) then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz1", 16)
    end
end
