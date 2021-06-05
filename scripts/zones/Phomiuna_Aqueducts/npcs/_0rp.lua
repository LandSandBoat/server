-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Thunder (West)
-- !pos -63 -26 67
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+5) -- lighting lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.LIGHTNINGDAY) then
        if (GetNPCByID(DoorOffset-2):getAnimation() == 8) then -- lamp water open ?
            GetNPCByID(DoorOffset-4):openDoor(15) -- Open Door _0rk
        end
    elseif (day == xi.day.EARTHSDAY) then
        if (GetNPCByID(DoorOffset+2):getAnimation() == 8) then -- lamp earth open ?
            GetNPCByID(DoorOffset-4):openDoor(15) -- Open Door _0rk
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
