-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Waypoint
--  SoA: Waypoint
-- !pos 20 -34.922 0.000
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local onwardToAdoulin = player:getCurrentMission(SOA) == tpz.mission.id.soa.ONWARD_TO_ADOULIN
    local adoulinAccess = player:getCurrentMission(SOA) > tpz.mission.id.soa.ONWARD_TO_ADOULIN

    if onwardToAdoulin then
        player:startEvent(10120)
    elseif adoulinAccess then
        player:startEvent(10121)
    else
        player:messageSpecial(ID.text.WAYPOINT_EXAMINE)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10120 and option == 1 then -- teleport
        player:setPos(172, 0.3, -21, 211, tpz.zone.CEIZAK_BATTLEGROUNDS)
    end
end

return entity
