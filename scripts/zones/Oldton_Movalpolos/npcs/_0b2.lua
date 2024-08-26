-----------------------------------
-- Area: Oldton_Movalpolos
--  NPC: _0b2
-- !pos 186.589 13.668 -80.186
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local gate = GetNPCByID(npc:getID() + 5)

    if not gate then
        return
    end

    npc:openDoor(30)
    gate:closeDoor(30)
end

return entity
