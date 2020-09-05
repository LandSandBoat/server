-----------------------------------
-- Area: Den of Rancor
--  NPC: Drop Gate (by Tonberry Decapitator)
-- !pos -139.976 3.591 -165.043 160
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.LANTERN_OFFSET) -- The grating will not budge.
end
