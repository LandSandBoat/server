-----------------------------------
-- Area: Sealion's Den
--  NPC: Sueleen
-- !pos 612 132 774 32
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_WARRIORS_PATH then
        player:startEvent(12)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 12 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.SEA)
    end
end

return entity
