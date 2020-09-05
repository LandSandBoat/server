-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Spacial Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if (offset >= 0 and offset <= 2) then
        player:startEvent(offset + 2)
    elseif (offset >= 7 and offset <= 39) then
        player:startEvent(offset)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 35 and option == 1) then
        player:setPos(12.527, 0.345, -539.602, 127, 31) -- to Monarch Linn (Retail confirmed)
    elseif (csid == 10 and option == 1) then
        player:setPos(-538.526, -29.5, 359.219, 255, 25) -- back to Misareaux Coast (Retail confirmed)
    end
end
