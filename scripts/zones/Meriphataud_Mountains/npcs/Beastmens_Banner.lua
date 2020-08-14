-----------------------------------
-- Area: Meriphataud_Mountains
--  NPC: Beastmen_s_Banner
-- !pos 592.850 -16.765 -518.802 119
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
