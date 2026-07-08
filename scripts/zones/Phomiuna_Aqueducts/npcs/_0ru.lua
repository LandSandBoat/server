-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Fire (West)
-- !pos -63 -26 43
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET) -- Fire lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if day == xi.day.FIRESDAY then
        if GetNPCByID(doorOffset-4):getAnimation() == 8 then -- Is the Ice lamp open?
            GetNPCByID(doorOffset-9):openDoor(15) -- Door _0rk
        end
    elseif day == xi.day.WATERSDAY then
        if GetNPCByID(doorOffset-2):getAnimation() == 8 then -- Is the Water lamp open?
            GetNPCByID(doorOffset-9):openDoor(15) -- Door _0rk
        end
    end
end

return entity
