-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - Earth (West)
-- !pos -63 -26 53
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+1) -- earth lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == tpz.day.WINDSDAY) then
        if (GetNPCByID(DoorOffset+1):getAnimation() == 8) then -- lamp wind open?
            GetNPCByID(DoorOffset-7):openDoor(15) -- Open Door _0rk
        end
    elseif (day == tpz.day.EARTHSDAY) then
        if (GetNPCByID(DoorOffset-3):getAnimation() == 8) then -- lamp lightning open?
            GetNPCByID(DoorOffset-7):openDoor(15) -- Open Door _0rk
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
