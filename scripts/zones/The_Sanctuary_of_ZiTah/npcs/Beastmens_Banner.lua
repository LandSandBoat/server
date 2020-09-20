-----------------------------------
-- Area: The_Sanctuary_of_ZiTah
--  NPC: Beastmen_s_Banner
-- !pos -399.822 0.161 -168.998 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
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
