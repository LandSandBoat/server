-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Wind (West)
-- !pos -63 -26 47
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+3) -- wind lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.WINDSDAY) then
        if (GetNPCByID(DoorOffset-1):getAnimation() == 8) then -- lamp earth open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rk
        end
    elseif (day == xi.day.ICEDAY) then
        if (GetNPCByID(DoorOffset-5):getAnimation() == 8) then -- lamp ice open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rk
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
