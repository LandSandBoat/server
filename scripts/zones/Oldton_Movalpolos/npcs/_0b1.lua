-----------------------------------
-- Area: Oldton_Movalpolos
--  NPC: _0b1
-- !pos 196.979 5.666 -71.369
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local gate = GetNPCByID(npc:getID() + 4)

    if not gate then
        return
    end

    npc:openDoor(30)
    gate:closeDoor(30)
end

return entity
