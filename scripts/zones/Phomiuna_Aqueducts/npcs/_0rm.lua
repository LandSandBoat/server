-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - North (West)
-- Opens Door at F-7 from inside.
-- !pos -63 -26 83
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local DoorOffset = npc:getID() - 1

    if GetNPCByID(DoorOffset):getAnimation() == 9 then
        if player:getZPos() < 84 then
            npc:openDoor(7) -- lamp animation
            GetNPCByID(DoorOffset):openDoor(7) -- _0rf
        end
    end
end

return entity
