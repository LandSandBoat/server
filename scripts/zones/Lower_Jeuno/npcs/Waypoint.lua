-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Waypoint
--  SoA: Waypoint
-- !pos 20 -34.922 0.000 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local adoulinAccess = player:getCurrentMission(SOA) > xi.mission.id.soa.ONWARD_TO_ADOULIN
    if adoulinAccess then
        player:startEvent(10121)
    else
        player:messageSpecial(ID.text.WAYPOINT_EXAMINE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
