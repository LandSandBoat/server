-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Sluice Gate #6 (Secret Hideout Entrance)
-- !pos TODO 258
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.WATERWAY_FACILITY_CRANK) then
        player:startEvent(361)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
