-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Earth (West)
-- !pos -63 -26 47
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local doorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET + 1) -- Earth lamp
    npc:openDoor(7) -- Lamp animation

    local day = VanadielDayOfTheWeek()

    if day == xi.day.WINDSDAY then
        if GetNPCByID(doorOffset-2):getAnimation() == 8 then -- Is the Wind lamp open?
            GetNPCByID(doorOffset-8):openDoor(15) -- Open Door _0rk
        end
    elseif day == xi.day.EARTHSDAY then
        if GetNPCByID(doorOffset-4):getAnimation() == 8 then -- Is the Thunder lamp open?
            GetNPCByID(doorOffset-8):openDoor(15) -- Open Door _0rk
        end
    end
end

return entity
