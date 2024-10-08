-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Sluice Gate #2
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local zone = npc:getZone()
    if not zone then
        return
    end

    local resultTable = zone:queryEntitiesByName('_76r')

    resultTable[1]:openDoor(15)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
