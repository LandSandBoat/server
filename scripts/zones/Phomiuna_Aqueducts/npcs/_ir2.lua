-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Earth (East)
-- !pos 104 -26 53
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+1) -- earth lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.WINDSDAY) then
        if (GetNPCByID(DoorOffset+1):getAnimation() == 8) then -- lamp wind open?
            GetNPCByID(DoorOffset-7):openDoor(15) -- Open Door _0rl
        end
    elseif (day == xi.day.EARTHSDAY) then
        if (GetNPCByID(DoorOffset-3):getAnimation() == 8) then -- lamp lightning open?
            GetNPCByID(DoorOffset-7):openDoor(15) -- Open Door _0rl
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
