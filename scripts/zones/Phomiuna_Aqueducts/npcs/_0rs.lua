-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Water (West)
-- !pos -63 -26 53
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET + 2) -- Water lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if day == xi.day.WATERSDAY then
        if GetNPCByID(doorOffset + 2):getAnimation() == 8 then -- Is the Fire lamp open?
            GetNPCByID(doorOffset - 7):openDoor(15) -- Open Door _0rk
        end
    elseif day == xi.day.LIGHTNINGDAY then
        if GetNPCByID(doorOffset - 3):getAnimation() == 8 then -- Is the Thunder lamp open?
            GetNPCByID(doorOffset - 7):openDoor(15) -- Open Door _0rk
        end
    end
end

return entity
