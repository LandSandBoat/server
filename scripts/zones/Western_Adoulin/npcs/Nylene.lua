-----------------------------------
-- Area: Western Adoulin
--  NPC: Nylene
-- Type: Standard NPC and Quest NPC
--  Involved with Quest: 'A Certain Substitute Patrolman'
-- !pos 12 0 -82 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local ACSP = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    local SOA_Mission = player:getCurrentMission(SOA)
    if (SOA_Mission >= tpz.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        if ((ACSP == QUEST_ACCEPTED) and (player:getCharVar("ACSP_NPCs_Visited") == 7)) then
            -- Progresses Quest: 'A Certain Substitute Patrolman'
            player:startEvent(2559)
        else
            -- Standard dialogue
            player:startEvent(562)
        end
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(533)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 2559) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 8)
    end
end
