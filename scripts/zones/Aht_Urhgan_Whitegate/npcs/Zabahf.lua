-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zabahf
-- Type: Standard NPC
-- !pos -90.070 -1 10.140 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local gotItAllProg = player:getCharVar("gotitallCS")
    if gotItAllProg == 1 or gotItAllProg == 3 then
        player:startEvent(533)
    elseif gotItAllProg == 2 then
        player:startEvent(523)
    elseif gotItAllProg == 5 then
        player:startEvent(538)
    elseif gotItAllProg == 6 then
        player:startEvent(540)
    elseif gotItAllProg == 7 then
        player:startEvent(535)
    elseif player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED then
        player:startEvent(530)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 523 then
        player:setCharVar("gotitallCS", 3)
    end
end
