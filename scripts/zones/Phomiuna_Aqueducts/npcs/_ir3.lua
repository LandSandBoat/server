-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - Wind (East)
-- !pos 104 -26 47
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+3) -- wind lamp
    npc:openDoor(7) -- lamp animation

    local element = VanadielDayElement()

    if (element == 3) then -- winday
        if (GetNPCByID(DoorOffset-1):getAnimation() == 8) then -- lamp earth open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rl
        end
    elseif (element == 4) then -- iceday
        if (GetNPCByID(DoorOffset-5):getAnimation() == 8) then -- lamp ice open?
            GetNPCByID(DoorOffset-8):openDoor(15) -- Open Door _0rl
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
