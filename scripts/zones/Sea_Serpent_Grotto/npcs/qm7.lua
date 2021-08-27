-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: ??? Used for Rhapsodies of Vanadiel Mission 1-14 The Ties that Bind
-- !pos 110.909 -0.095 -6.851 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(ROV) == xi.mission.id.rov.THE_TIES_THAT_BIND then
        player:startEvent(34)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 34 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_TIES_THAT_BIND)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.IMPURITY)
    end
end
return entity
