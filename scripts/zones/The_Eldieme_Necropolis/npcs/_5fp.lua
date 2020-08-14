-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: West Plate
-- !pos 128 -34 20 195
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
