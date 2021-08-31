-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Darkness (West)
-- !pos -63 -26 57
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+7) -- dark lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.LIGHTSDAY or day == xi.day.DARKSDAY) then
        if (GetNPCByID(DoorOffset-1):getAnimation() == 8) then -- lamp light open ?
            GetNPCByID(DoorOffset-6):openDoor(15) -- Open Door _0rk
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
