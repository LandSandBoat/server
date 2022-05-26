-----------------------------------
-- Area: Lower Jeuno (245)
--  NPC: Waypoint
--  SoA: Waypoint
-- !pos 20 -34.922 0.000 245
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/waypoint')
require('scripts/globals/zone')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.ADOULINIAN_CHARTER_PERMIT) then
        xi.waypoint.onTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
