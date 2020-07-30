-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - Thunder (West)
-- !pos -63 -26 67
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+5) -- lighting lamp
    npc:openDoor(7) -- lamp animation

    local element = VanadielDayElement()

    if (element == 5) then -- lightningday
        if (GetNPCByID(DoorOffset-2):getAnimation() == 8) then -- lamp water open ?
            GetNPCByID(DoorOffset-4):openDoor(15) -- Open Door _0rk
        end
    elseif (element == 1) then -- earthday
        if (GetNPCByID(DoorOffset+2):getAnimation() == 8) then -- lamp earth open ?
            GetNPCByID(DoorOffset-4):openDoor(15) -- Open Door _0rk
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
