-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Beastmen_s_Banner
-- !pos -257 8 -249 114
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

function onEventUpdate(player, csid, option)
    -- printf("OPTION: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("OPTION: %u", option)
end
