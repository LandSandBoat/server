-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Wind (West)
-- !pos -63 -26 57
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET + 3) -- Wind lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if day == xi.day.WINDSDAY then
        if GetNPCByID(doorOffset + 2):getAnimation() == 8 then -- Is the Earth lamp open?
            GetNPCByID(doorOffset - 6):openDoor(15) -- Open Door _0rk
        end
    elseif day == xi.day.ICEDAY then
        if GetNPCByID(doorOffset - 1):getAnimation() == 8 then -- Is the Ice lamp open?
            GetNPCByID(doorOffset - 6):openDoor(15) -- Open Door _0rk
        end
    end
end

return entity
