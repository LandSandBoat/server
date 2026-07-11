-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Sluice Gate #1
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local zone = npc:getZone()
    if not zone then
        return
    end

    local resultTable = zone:queryEntitiesByName('_76s')

    resultTable[1]:openDoor(10)
end

return entity
