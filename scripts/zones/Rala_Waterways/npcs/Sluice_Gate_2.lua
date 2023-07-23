-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Sluice Gate #2
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local zone = npc:getZone()
    local resultTable = zone:queryEntitiesByName('_76r')

    resultTable[1]:openDoor(15)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
