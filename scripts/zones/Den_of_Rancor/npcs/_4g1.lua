-----------------------------------
-- Area: Den of Rancor
--  NPC: Drop Gate (by Hakutaku)
-- !pos 5.044 23.590 -299.976 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET) -- The grating will not budge.
end
