-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Water (West)
-- !pos -63 -26 77
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+2) -- water lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.WATERSDAY) then
        if (GetNPCByID(DoorOffset+7):getAnimation() == 8) then -- lamp fire open?
            GetNPCByID(DoorOffset-2):openDoor(15) -- Open Door _0rk
        end
    elseif (day == xi.day.LIGHTNINGDAY) then
        if (GetNPCByID(DoorOffset+2):getAnimation() == 8) then -- lamp lightning open?
            GetNPCByID(DoorOffset-2):openDoor(15) -- Open Door _0rk
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
