-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Beastmen_s_Banner
-- !pos 366.014 -0.185 -394.801 124
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
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
