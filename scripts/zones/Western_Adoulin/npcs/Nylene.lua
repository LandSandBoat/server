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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ACSP = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    local SOA_Mission = player:getCurrentMission(SOA)
    if (SOA_Mission >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER) then
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2559) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 8)
    end
end

return entity
