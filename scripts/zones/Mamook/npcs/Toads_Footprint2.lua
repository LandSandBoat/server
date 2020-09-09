-----------------------------------
-- Area: Mamook
-- NPC: Toads Footprint
-- !pos -42.9248 5.9847 -100.2972
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local princeandhopper = player:getCharVar("princeandhopper")
    if princeandhopper == 2 then
        player:startEvent(222)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 222 then
        player:setCharVar("princeandhopper", 3)
        player:startEvent(227)
    end
end
