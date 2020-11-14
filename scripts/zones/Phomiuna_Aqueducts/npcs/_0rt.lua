-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - Wind (West)
-- !pos -63 -26 47
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+3) -- wind lamp
    npc:openDoor(7) -- lamp animation

    local day = VanadielDayOfTheWeek()

    if (day == tpz.day.WINDSDAY) then
        if (GetNPCByID(DoorOffset-1):getAnimation() == 8) then -- lamp earth open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rk
        end
    elseif (day == tpz.day.ICEDAY) then
        if (GetNPCByID(DoorOffset-5):getAnimation() == 8) then -- lamp ice open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rk
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
