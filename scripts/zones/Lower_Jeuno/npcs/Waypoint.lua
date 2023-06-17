-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Waypoint
--  SoA: Waypoint
-- !pos 20 -34.922 0.000 245
-----------------------------------
require('scripts/globals/waypoint')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.waypoint.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.ADOULINIAN_CHARTER_PERMIT) then
        xi.waypoint.onTrigger(player, npc)
    else
        player:messageSpecial(ID.text.WAYPOINT_EXAMINE)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.waypoint.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.waypoint.onEventFinish(player, csid, option, npc)
end

return entity
