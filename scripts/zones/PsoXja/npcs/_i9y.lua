-----------------------------------
-- Area: Pso'Xja
--  NPC: _i9y (Crystal Receptor)
-- !pos -389.980 -3.198 -203.595 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (npc:getAnimation() == 9) then
        player:startEvent(58)
    else
        player:messageSpecial(ID.text.DEVICE_IN_OPERATION)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 58) then
        local CrystalOperator = npc:getID()
        npc:openDoor(118) -- this sets the trigger animation to glowing. The time is retail confirmed.
        GetNPCByID(CrystalOperator+1):closeDoor(118) -- tiles will reset at the same time.
    end
end
