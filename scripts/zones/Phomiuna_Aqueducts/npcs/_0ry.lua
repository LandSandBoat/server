-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: Oil Lamp - Ice (East)
-- !pos 104 -26 73
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+4) -- ice lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == xi.day.FIRESDAY) then
        if (GetNPCByID(DoorOffset+6):getAnimation() == 8) then -- lamp fire open?
            GetNPCByID(DoorOffset-3):openDoor(15) -- Open Door _0rl
        end
    elseif (day == xi.day.ICEDAY) then
        if (GetNPCByID(DoorOffset+5):getAnimation() == 8) then -- lamp wind open?
            GetNPCByID(DoorOffset-3):openDoor(15) -- Open Door _0rl
        end
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
