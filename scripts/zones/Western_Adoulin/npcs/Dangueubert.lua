-----------------------------------
-- Area: Western Adoulin
--  NPC: Dangueubert
-- Type: Standard NPC and Quest NPC
-- Involved with Quest: 'A Certain Substitute Patrolman'
-- !pos 5 0 -136 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)
    local ACSP = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)

    if (SOA_Mission >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        if ((ACSP == QUEST_ACCEPTED) and (player:getCharVar("ACSP_NPCs_Visited") == 6)) then
            -- Progresses Quest: 'A Certain Substitute Patrolman'
            player:startEvent(2558)
        else
            -- Standard dialogue
            player:startEvent(546, 0, 1)
        end
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(546)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2558) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 7)
    elseif (csid == 546) then
        if (option == 1) then
            -- Warps player to Mog Garden
            player:setPos(0, 0, 0, 0, 280)
        end
    end
end

return entity
