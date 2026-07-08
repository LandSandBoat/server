-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - North (East)
-- Opens Door at J-7 from inside.
-- !pos 104 -26 83
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local DoorOffset = npc:getID() - 1

    if GetNPCByID(DoorOffset):getAnimation() == 9 then
        if player:getZPos() < 85 then
            npc:openDoor(7) -- torch animation
            GetNPCByID(DoorOffset):openDoor(7) -- _0rh
        end
    end
end

return entity
