-----------------------------------
-- Area: Den of Rancor
--  NPC: Drop Gate (by Sacrificial Chamber)
-- !pos -60 46 32 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET) -- The grating will not budge.
end
