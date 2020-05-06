-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: South Plate
-- !pos 185 -32 -10 195
-----------------------------------
local func = require("scripts/zones/The_Eldieme_Necropolis/globals")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.plateOnTrigger(npc)
    return 0
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
