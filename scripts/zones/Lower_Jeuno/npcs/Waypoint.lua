-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Waypoint
--  SoA: Waypoint
-- !pos 20 -34.922 0.000
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(SOA) == xi.mission.id.soa.ONWARD_TO_ADOULIN then
        player:startEvent(10120)
    elseif player:getCurrentMission(SOA) > xi.mission.id.soa.ONWARD_TO_ADOULIN then
        player:startEvent(10121)
    else
        player:messageSpecial(ID.text.WAYPOINT_EXAMINE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10120 and option == 1 then -- teleport
        player:setPos(172, 0.3, -21, 211, xi.zone.CEIZAK_BATTLEGROUNDS)
    end
end

return entity
