-----------------------------------
-- Area: Western Adoulin
--  NPC: Dangueubert
-- Type: Standard NPC and Quest NPC
-- Involved with Quest: 'A Certain Substitute Patrolman'
-- !pos 5 0 -136 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.SOA) >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        -- Standard dialogue
        player:startEvent(546, 0, 1)
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(546)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 546 and option == 1 then
        -- Warps player to Mog Garden
        player:setPos(0, 0, 0, 0, 280)
    end
end

return entity
