-----------------------------------
-- Area: Western Adoulin
--  NPC: Virsaint
-- Type: Standard NPC and Quest NPC
--  Involved with Quests: 'A Certain Substitute Patrolman'
-- !pos 32 0 -5 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ACSP = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    if ((ACSP == QUEST_ACCEPTED) and (player:getCharVar("ACSP_NPCs_Visited") == 4)) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:startEvent(2556)
    else
        -- Standard dialogue
        player:startEvent(540)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2556) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 5)
    end
end
