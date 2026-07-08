-----------------------------------
-- Area: Mount Zhayolm
-- Door: Gates of Halvung
-- !pos 189 -19 -20 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.CAST_METAL_PLATE) then
        player:messageSpecial(ID.text.INSERT_INTO_KEYHOLE, xi.ki.CAST_METAL_PLATE)
        npc:openDoor(10)
    else
        player:messageSpecial(ID.text.LARGE_KEYHOLE_HERE)
        player:setCharVar('HalvungDoor', 1)
    end
end

return entity
