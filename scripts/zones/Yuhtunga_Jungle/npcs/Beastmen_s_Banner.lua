-----------------------------------
-- Area: Yuhtunga_Jungle
--  NPC: Beastmen_s_Banner
-- !pos -305.061 16.172 -438.904 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
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
