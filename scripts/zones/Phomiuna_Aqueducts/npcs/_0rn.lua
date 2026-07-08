-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Darkness (West)
-- !pos -63 -26 77
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET + 7) -- Dark lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if
        day == xi.day.LIGHTSDAY or
        day == xi.day.DARKSDAY
    then
        if GetNPCByID(doorOffset + 1):getAnimation() == 8 then -- Is the Light lamp open?
            GetNPCByID(doorOffset - 2):openDoor(15) -- Opens Door _0rk
        end
    end
end

return entity
