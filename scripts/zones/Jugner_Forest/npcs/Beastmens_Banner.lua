-----------------------------------
-- Area: Jugner_Forest
--  NPC: Beastmen_s_Banner
-- !pos 448.240 0.210 -157.228 104
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
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
