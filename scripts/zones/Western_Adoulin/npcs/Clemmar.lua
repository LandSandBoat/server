-----------------------------------
-- Area: Western Adoulin
--  NPC: Clemmar
-- Type: Standard NPC and Quest NPC
--  Involved with Quest: 'A Certain Substitute Patrolman'
-- !pos -12 0 12 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ACSP = player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN)
    local SOA_Mission = player:getCurrentMission(SOA)
    if (SOA_Mission >= tpz.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        if ((ACSP == QUEST_ACCEPTED) and (player:getCharVar("ACSP_NPCs_Visited") == 2)) then
            -- Progresses Quest: 'A Certain Substitute Patrolman'
            player:startEvent(2554)
        else
            -- Standard dialogue
            player:startEvent(570)
        end
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(519)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 2554) then
        -- Progresses Quest: 'A Certain Substitute Patrolman'
        player:setCharVar("ACSP_NPCs_Visited", 3)
    end
end

return entity
