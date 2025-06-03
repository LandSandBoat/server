-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Ice (West)
-- !pos -63 -26 63
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET + 4) -- Ice lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if day == xi.day.FIRESDAY then
        if GetNPCByID(doorOffset + 4):getAnimation() == 8 then -- Is the Fire lamp open?
            GetNPCByID(doorOffset - 5):openDoor(15) -- Open Door _0rk
        end
    elseif day == xi.day.ICEDAY then
        if GetNPCByID(doorOffset + 1):getAnimation() == 8 then -- Is the Wind lamp open?
            GetNPCByID(doorOffset - 5):openDoor(15) -- Open Door _0rk
        end
    end
end

return entity
