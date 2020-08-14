-----------------------------------
-- Area: Phomiuna_Aqueducts
-- NPC: Oil Lamp - Water (East)
-- !pos 104 -26 77
-----------------------------------
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local DoorOffset = npc:getID()

    player:messageSpecial(ID.text.LAMP_OFFSET+2) -- water lamp
    npc:openDoor(7) -- lamp animation

    local element = VanadielDayElement()

    if (element == 2) then -- waterday
        if (GetNPCByID(DoorOffset+7):getAnimation() == 8) then -- lamp fire open?
            GetNPCByID(DoorOffset-2):openDoor(15) -- Open Door _0rl
        end
    elseif (element == 5) then -- lighningday
        if (GetNPCByID(DoorOffset+2):getAnimation() == 8) then -- lamp lightning open?
            GetNPCByID(DoorOffset-2):openDoor(15) -- Open Door _0rl
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
