-----------------------------------
-- Area: Xarcabard
--  NPC: Beastmen_s_Banner
-- !pos 153.000 -36.444 23.500 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
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
